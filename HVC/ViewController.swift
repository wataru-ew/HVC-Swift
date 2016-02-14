//
//  ViewController.swift
//  HVC
//
//  Created by wataru on 2016/02/11.
//  Copyright © 2016年 wataru. All rights reserved.
//

import UIKit


class ViewController: UIViewController, HVC_Delegate {

    var Status:Int = 0
    var ExecuteFlag:HVC_FUNCTION = HVC_FUNCTION()
    var Hvc_BLE:HVC_BLE = HVC_BLE()
    
    @IBOutlet weak var Result_Text_View: UITextView!
    @IBOutlet weak var pushbutton: UIButton!
    @IBOutlet weak var btnExecution: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Ex = [.HVC_ACTIV_AGE_ESTIMATION , .HVC_ACTIV_HAND_DETECTION]
        Hvc_BLE.delegateHVC = self
        Result_Text_View.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pushButton(sender: AnyObject) {
        switch(Status){
        case 0:
            self.Hvc_BLE.deviceSearch()
            self.pushbutton.setTitle("disconnect", forState: .Normal)
            Status = 1
            break
        case 1:
            self.Hvc_BLE.disconnect()
            self.pushbutton.setTitle("connect", forState: .Normal)
            Status = 0
            return
        default:
            break
        }
        let semaphore: dispatch_semaphore_t = dispatch_semaphore_create(0)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            for (var i=0; i<10; i++){
                sleep(1)
            }
            dispatch_semaphore_signal(semaphore)
        })
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        
        let alert:UIAlertController = UIAlertController(title: "Connect Device",
            message: "Select HVC",
            preferredStyle: .Alert)

        let cancelAction = UIAlertAction(title: "cancel", style: .Cancel) {
            action in self.Status = 0
        }
        let deviseList: NSMutableArray = self.Hvc_BLE.getDevices()
        //for (var i=0; i<deviseList.count; i++){
            let name:String = deviseList[0].name
            let otherAction = UIAlertAction(title: name, style: .Default) {
                action in
                self.Hvc_BLE.connect(deviseList[0] as! CBPeripheral)
                self.pushbutton.setTitle("disconnect", forState: .Normal)
                self.Status = 1
            }
            alert.addAction(otherAction)
        //}

        alert.addAction(cancelAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    @IBAction func btnExecute_click(sender: AnyObject) {
        switch(Status){
        case 0:
            return
        case 1:
            self.btnExecution.setTitle("stop", forState: .Normal)
            Status = 2
            break
        case 2:
            self.btnExecution.setTitle("start", forState: .Normal)
            Status = 1
            return
        default:
            break
        }
        let param:HVC_PRM = HVC_PRM()
        param.face().setMinSize(60)
        param.face().setMaxSize(480)
        
        self.Hvc_BLE.setParam(param)
    }
    
    func onConnected() {
        let alert:UIAlertController = UIAlertController(title: "SUCCESS", message: "Connected", preferredStyle: .Alert)
        let otherAction = UIAlertAction(title: "OK", style: .Default){
            action in print("Connected")
        }
        alert.addAction(otherAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func onDisconnected() {
        let alert:UIAlertController = UIAlertController(title: "SUCCESS", message: "Disconnected", preferredStyle: .Alert)
        let otherAction = UIAlertAction(title: "OK", style: .Default){
            action in print("Disconnected")
        }
        alert.addAction(otherAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func onPostSetParam(err: HVC_ERRORCODE, status outStatus: UInt8) {
        dispatch_async(dispatch_get_main_queue(), {
            self.ExecuteFlag = [.ACTIV_AGE_ESTIMATION, .ACTIV_BLINK_ESTIMATION, .ACTIV_BODY_DETECTION, .ACTIV_EXPRESSION_ESTIMATION, .ACTIV_FACE_DETECTION, .ACTIV_FACE_DIRECTION, .ACTIV_GAZE_ESTIMATION, .ACTIV_GENDER_ESTIMATION]
            
            let res:HVC_RES = HVC_RES()
            self.Hvc_BLE.Execute(self.ExecuteFlag, result: res)
        })
    }
    
    func onPostGetParam(param: HVC_PRM, errcode err:HVC_ERRORCODE, status outStatus: UInt8){
        
    }
    
    func onPostGetVersion(ver: HVC_VER, errcode err:HVC_ERRORCODE, status outStatus: UInt8){
        
    }
    
    func onPostExecute(result: HVC_RES, errcode err:HVC_ERRORCODE, status outStatus: UInt8){
        var resStr:String = ""
        if((err == .NORMAL) && (outStatus == 0)){
            resStr += "Body Detect = \(result.sizeBody())\n"
            
            for(var i=0; i<result.sizeBody(); i++){
                let dt:DetectionResult = result.body(i)
                resStr += "  [Body Detection] : size = \(dt.size())\n"
                resStr += "x = \(dt.posY()), y = \(dt.posY())\n"
                resStr += "conf = \(dt.confidence())\n"
            }
            
            resStr += "Hand Detect = \(result.sizeHand())\n"
            for(var i=0;i<result.sizeHand(); i++){
                let dt:DetectionResult = result.hand(i)
                resStr += "  [Hand Detection] : size = \(dt.size())"
                resStr += "x = \(dt.posX()) y = \(dt.posY())\n"
                resStr += "conf = \(dt.confidence)\n"
            }
            
            resStr += "Face Detect = \(result.sizeFace())\n"
            for(var i=0;i<result.sizeFace(); i++){
                let fd:FaceResult = result.face(i)
                
                if([result.executedFunc(), HVC_FUNCTION.ACTIV_FACE_DETECTION] != HVC_FUNCTION.ZERO){
                    resStr += "  [Face Detection] : size = \(fd.size())\n"
                    resStr += "x = \(fd.posX()), y = \(fd.posY())\n"
                    resStr += "conf = \(fd.confidence())\n"
                }
                
                if([result.executedFunc(), HVC_FUNCTION.ACTIV_FACE_DIRECTION] != HVC_FUNCTION.ZERO){
                    resStr += "  [Face Direction] :  \n"
                    resStr += "yaw = \(fd.dir().yaw())"
                    resStr += "pitch = \(fd.dir().pitch())\n"
                    resStr += "roll = \(fd.dir().roll())\n"
                    resStr += "conf = \(fd.dir().confidence())\n"
                    
                }
                
                if([result.executedFunc(), HVC_FUNCTION.ACTIV_AGE_ESTIMATION] != HVC_FUNCTION.ZERO){
                    resStr += "  [Age Estimation] : \n"
                    resStr += "age = \(fd.age().age()), conf = \(fd.age().confidence())\n"
                }
                
                if([result.executedFunc(), HVC_FUNCTION.ACTIV_GENDER_ESTIMATION] != HVC_FUNCTION.ZERO){
                    resStr += "  [Gender Estimation] : \n"
                    var gender:String = ""
                    if(fd.gen().gender() == HVC_GENDER.GEN_MALE){
                        gender = "Male"
                    }else{
                        gender = "FeMale"
                    }
                    resStr += "gender = \(gender), conf = \(fd.gen().confidence())\n"
                }
                
                if([result.executedFunc(), HVC_FUNCTION.ACTIV_GAZE_ESTIMATION] != HVC_FUNCTION.ZERO){
                    resStr += "  [Gaze Estimation] : \n"
                    resStr += "LR = \(fd.gaze().gazeLR()), UD = \(fd.gaze().gazeUD())\n"
                }
                
                if([result.executedFunc(), HVC_FUNCTION.ACTIV_GAZE_ESTIMATION] != HVC_FUNCTION.ZERO){
                    resStr += "  [Blink Estimation] : \n"
                    resStr += "rotioL = \(fd.blink().ratioL()), ratioR = \(fd.blink().ratioR())\n"
                }
                
                if([result.executedFunc(), HVC_FUNCTION.ACTIV_EXPRESSION_ESTIMATION] != HVC_FUNCTION.ZERO){
                    resStr += "  [Expression Estimation] : \n"
                    var expression:String = ""
                    switch(fd.exp().expression()){
                    case HVC_EXPRESSION.EX_NEUTRAL:
                        expression = "Neutral";
                        break
                    case HVC_EXPRESSION.EX_HAPPINESS:
                        expression = "Happiness";
                        break
                    case HVC_EXPRESSION.EX_SURPRISE:
                        expression = "Surprise";
                        break
                    case HVC_EXPRESSION.EX_ANGER:
                        expression = "Anger";
                        break
                    case HVC_EXPRESSION.EX_SADNESS:
                        expression = "Sadness";
                        break
                    default:
                        break
                    }
                    resStr += "expression = \(expression)\n"
                    resStr += "score = \(fd.exp().score())\n"
                    resStr += "degree = \(fd.exp().degree())\n"
                }
            }
        }
        Result_Text_View.text = resStr
        if(Status == 2){
            dispatch_async(dispatch_get_main_queue(), {
                self.Hvc_BLE.Execute(self.ExecuteFlag, result: result)
            })
        }
    }
}

