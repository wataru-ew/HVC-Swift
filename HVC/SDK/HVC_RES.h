/*
 * Copyright (C) 2014-2015 OMRON Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  HVC_RES.h
//

#import <Foundation/Foundation.h>

#import "HVCC_Define.h"

/**
 * Detection result
 */
@interface DetectionResult : NSObject
{
    /**
     * Center x-coordinate
     */
    NSInteger posX;
    /**
     * Center y-coordinate
     */
    NSInteger posY;
    /**
     * Size
     */
    NSInteger size;
    /**
     * Degree of confidence
     */
    NSInteger confidence;
}

// Accessor
-(void) setPosX:(NSInteger)val;
-(NSInteger)posX;
-(void) setPosY:(NSInteger)val;
-(NSInteger)posY;
-(void) setSize:(NSInteger)val;
-(NSInteger)size;
-(void) setConfidence:(NSInteger)val;
-(NSInteger)confidence;

@end


/**
 * Face direction
 */
@interface DirResult : NSObject
{
    /**
     * Yaw angle
     */
    NSInteger yaw;
    /**
     * Pitch angle
     */
    NSInteger pitch;
    /**
     * Roll angle
     */
    NSInteger roll;
    /**
     * Degree of confidence
     */
    NSInteger confidence;
}

// Accessor
-(void) setYaw:(NSInteger)val;
-(NSInteger)yaw;
-(void) setPitch:(NSInteger)val;
-(NSInteger)pitch;
-(void) setRoll:(NSInteger)val;
-(NSInteger)roll;
-(void) setConfidence:(NSInteger)val;
-(NSInteger)confidence;

@end


/**
 * Age
 */
@interface AgeResult : NSObject
{
    /**
     * Age
     */
    NSInteger age;
    /**
     * Degree of confidence
     */
    NSInteger confidence;
}

// Accessor
-(void) setAge:(NSInteger)val;
-(NSInteger)age;
-(void) setConfidence:(NSInteger)val;
-(NSInteger)confidence;

@end


/**
 * Gender
 */
@interface GenResult : NSObject
{
    /**
     * Gender
     */
    HVC_GENDER  gender;
    /**
     * Degree of confidence
     */
    NSInteger confidence;
}

// Accessor
-(void) setGender:(HVC_GENDER)val;
-(HVC_GENDER)gender;
-(void) setConfidence:(NSInteger)val;
-(NSInteger)confidence;

@end


/**
 * Gaze
 */
@interface GazeResult : NSObject
{
    /**
     * Yaw angle
     */
    NSInteger gazeLR;
    /**
     * Pitch angle
     */
    NSInteger gazeUD;
}

// Accessor
-(void) setGazeLR:(NSInteger)val;
-(NSInteger)gazeLR;
-(void) setGazeUD:(NSInteger)val;
-(NSInteger)gazeUD;

@end


/**
 * Blink
 */
@interface BlinkResult : NSObject
{
    /**
     * Left eye blink result
     */
    NSInteger ratioL;
    /**
     * Right eye blink result
     */
    NSInteger ratioR;
}

// Accessor
-(void) setRatioL:(NSInteger)val;
-(NSInteger)ratioL;
-(void) setRatioR:(NSInteger)val;
-(NSInteger)ratioR;

@end


/**
 * Expression
 */
@interface ExpResult : NSObject
{
    /**
     * Expression
     */
    HVC_EXPRESSION expression;
    /**
     * Score
     */
    NSInteger score;
    /**
     * Negative-positive degree
     */
    NSInteger degree;
}

// Accessor
-(void) setExpression:(HVC_EXPRESSION)val;
-(HVC_EXPRESSION)expression;
-(void) setScore:(NSInteger)val;
-(NSInteger)score;
-(void) setDegree:(NSInteger)val;
-(NSInteger)degree;

@end


/**
 * Face Detection & Estimations results
 */
@interface FaceResult : DetectionResult
{
    /**
     * Face direction estimation result
     */
    DirResult *dir;
    /**
     * Age Estimation result
     */
    AgeResult *age;
    /**
     * Gender Estimation result
     */
    GenResult *gen;
    /**
     * Gaze Estimation result
     */
    GazeResult *gaze;
    /**
     * Blink Estimation result
     */
    BlinkResult *blink;
    /**
     * Expression Estimation result
     */
    ExpResult *exp;
}

// Accessor
-(void) setDir:(DirResult *)val;
-(DirResult *)dir;
-(void) setAge:(AgeResult *)val;
-(AgeResult *)age;
-(void) setGen:(GenResult *)val;
-(GenResult *)gen;
-(void) setGaze:(GazeResult *)val;
-(GazeResult *)gaze;
-(void) setBlink:(BlinkResult *)val;
-(BlinkResult *)blink;
-(void) setExp:(ExpResult *)val;
-(ExpResult *)exp;

@end


/**
 * HVC execution result 
 */
@interface HVC_RES : NSObject
{
    /**
     * Execution flag
     */
    HVC_FUNCTION executedFunc;
    /**
     * Human Body Detection results
     */
    NSMutableArray *body;
    /**
     * Hand Detection results
     */
    NSMutableArray *hand;
    /**
     * Face Detection, Estimations results
     */
    NSMutableArray *face;
}

// Reset
-(void)Reset:(HVC_FUNCTION)func;

// Accessor

// setter executedFunc
-(void) setExecutedFunc:(HVC_FUNCTION)func;
// getter executedFunc
-(HVC_FUNCTION)executedFunc;
// setter body DetectionResult
-(void) setBody:(DetectionResult *)dt;
// getter body DetectionResult
-(DetectionResult *)body:(NSInteger)index;
// Count of body DetectionResult
-(NSInteger)sizeBody;
// setter hand DetectionResult
-(void) setHand:(DetectionResult *)dt;
// getter hand DetectionResult
-(DetectionResult *)hand:(NSInteger)index;
// Count of hand DetectionResult
-(NSInteger)sizeHand;
// setter face DetectionResult
-(void) setFace:(FaceResult *)fd;
// getter face DetectionResult
-(FaceResult *)face:(NSInteger)index;
// Count of face DetectionResult
-(NSInteger)sizeFace;

@end
