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
//  HVC_RES.m
//

#import "HVC_RES.h"

/**
 * Detection result
 */
@implementation DetectionResult

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        posX = -1;
        posY = -1;
        size = -1;
        confidence = -1;
    }
    return self;
}

// Accessor
-(void) setPosX:(NSInteger)val { posX = val; }
-(NSInteger)posX { return posX; }
-(void) setPosY:(NSInteger)val { posY = val; }
-(NSInteger)posY { return posY; }
-(void) setSize:(NSInteger)val { size = val; }
-(NSInteger)size { return size; }
-(void) setConfidence:(NSInteger)val { confidence = val; }
-(NSInteger)confidence { return confidence; }

@end


/**
 * Face direction
 */
@implementation DirResult

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        yaw = -1;
        pitch = -1;
        roll = -1;
        confidence = -1;
    }
    return self;
}

// Accessor
-(void) setYaw:(NSInteger)val { yaw = val; }
-(NSInteger)yaw { return yaw; }
-(void) setPitch:(NSInteger)val { pitch = val; }
-(NSInteger)pitch { return pitch; }
-(void) setRoll:(NSInteger)val { roll = val; }
-(NSInteger)roll { return roll; }
-(void) setConfidence:(NSInteger)val { confidence = val; }
-(NSInteger)confidence { return confidence; }

@end


/**
 * Age
 */
@implementation AgeResult

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        age = -1;
        confidence = -1;
    }
    return self;
}

// Accessor
-(void) setAge:(NSInteger)val { age = val; }
-(NSInteger)age { return age; }
-(void) setConfidence:(NSInteger)val { confidence = val; }
-(NSInteger)confidence { return confidence; }

@end


/**
 * Gender
 */
@implementation GenResult

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        gender = -1;
        confidence = -1;
    }
    return self;
}

// Accessor
-(void) setGender:(HVC_GENDER)val { gender = val; }
-(HVC_GENDER)gender { return gender; }
-(void) setConfidence:(NSInteger)val { confidence = val; }
-(NSInteger)confidence { return confidence; }

@end


/**
 * Gaze
 */
@implementation GazeResult

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        gazeLR = -1;
        gazeUD = -1;
    }
    return self;
}

// Accessor
-(void) setGazeLR:(NSInteger)val { gazeLR = val; }
-(NSInteger)gazeLR { return gazeLR; }
-(void) setGazeUD:(NSInteger)val { gazeUD = val; }
-(NSInteger)gazeUD { return gazeUD; }

@end


/**
 * Blink
 */
@implementation BlinkResult

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        ratioL = -1;
        ratioR = -1;
    }
    return self;
}

// Accessor
-(void) setRatioL:(NSInteger)val { ratioL = val; }
-(NSInteger)ratioL { return ratioL; }
-(void) setRatioR:(NSInteger)val { ratioR = val; }
-(NSInteger)ratioR { return ratioR; }

@end


/**
 * Expression
 */
@implementation ExpResult

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        expression = -1;
        score = -1;
        degree = -1;
    }
    return self;
}

// Accessor
-(void) setExpression:(HVC_EXPRESSION)val { expression = val; }
-(HVC_EXPRESSION)expression { return expression; }
-(void) setScore:(NSInteger)val { score = val; }
-(NSInteger)score { return score; }
-(void) setDegree:(NSInteger)val { degree = val; }
-(NSInteger)degree { return degree; }

@end


/**
 * Face Detection & Estimations results
 */
@implementation FaceResult

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        dir = [[DirResult alloc] init];
        age = [[AgeResult alloc] init];
        gen = [[GenResult alloc] init];
        gaze = [[GazeResult alloc] init];
        blink = [[BlinkResult alloc] init];
        exp = [[ExpResult alloc] init];
    }
    return self;
}

// Accessor
-(void) setDir:(DirResult *)val { dir = val; }
-(DirResult *)dir { return dir; }
-(void) setAge:(AgeResult *)val { age = val; }
-(AgeResult *)age { return age; }
-(void) setGen:(GenResult *)val { gen = val; }
-(GenResult *)gen { return gen; }
-(void) setGaze:(GazeResult *)val { gaze = val; }
-(GazeResult *)gaze { return gaze; }
-(void) setBlink:(BlinkResult *)val { blink = val; }
-(BlinkResult *)blink { return blink; }
-(void) setExp:(ExpResult *)val { exp = val; }
-(ExpResult *)exp { return exp; }

@end


/**
 * HVC execution result 
 */
@implementation HVC_RES

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        executedFunc = 0;
        body = [NSMutableArray array];
        hand = [NSMutableArray array];
        face = [NSMutableArray array];
    }
    return self;
}

// Reset
-(void)Reset:(HVC_FUNCTION)func
{
    executedFunc = func;
    [body removeAllObjects];
    [hand removeAllObjects];
    [face removeAllObjects];
}

// Accessor

// setter executedFunc
-(void) setExecutedFunc:(HVC_FUNCTION)func
{
    executedFunc = func;
}
// getter executedFunc
-(HVC_FUNCTION)executedFunc
{
    return executedFunc;
}

// setter body DetectionResult
-(void) setBody:(DetectionResult *)dt
{
    [body addObject:dt];
}

// getter body DetectionResult
-(DetectionResult *)body:(NSInteger)index
{
    return body[index];
}

// Count of body DetectionResult
-(NSInteger)sizeBody
{
    return (NSInteger)body.count;
}

// setter hand DetectionResult
-(void) setHand:(DetectionResult *)dt
{
    [hand addObject:dt];
}

// getter hand DetectionResult
-(DetectionResult *)hand:(NSInteger)index
{
    return hand[index];
}

// Count of hand DetectionResult
-(NSInteger)sizeHand
{
    return (NSInteger)hand.count;
}

// setter face DetectionResult
-(void) setFace:(FaceResult *)fd
{
    [face addObject:fd];
}

// getter face DetectionResult
-(FaceResult *)face:(NSInteger)index
{
    return face[index];
}

// Count of face DetectionResult
-(NSInteger)sizeFace
{
    return (NSInteger)face.count;
}

@end
