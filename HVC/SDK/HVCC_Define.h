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
//  HVCC_Define.h
//

#import <Foundation/Foundation.h>

// Define ERROR CODE
typedef NS_OPTIONS(NSInteger, HVC_ERRORCODE){
    // Normal end
    HVC_NORMAL = 0,
    // Parameter error
    HVC_ERROR_PARAMETER = -1,
    // Device error
    HVC_ERROR_NODEVICES = -2,
    // Connection error
    HVC_ERROR_DISCONNECTED = -3,
    // Cannot re-input
    HVC_ERROR_BUSY = -4,
    // Send signal timeout error
    HVC_ERROR_SENDDATA = -10,
    // Receive header signal timeout error
    HVC_ERROR_HEADER_TIMEOUT = -20,
    // Invalid header error
    HVC_ERROR_HEADER_INVALID = -21,
    // Receive data signal timeout error
    HVC_ERROR_DATA_TIMEOUT = -22,
};

// Define Execution Function

typedef NS_OPTIONS(NSInteger, HVC_FUNCTION){
    HVC_ZERO                        = 0x00000000,
    // 人体検出
    HVC_ACTIV_BODY_DETECTION        = 0x00000001,
    // 手検出
    HVC_ACTIV_HAND_DETECTION        = 0x00000002,
    // 顔検出
    HVC_ACTIV_FACE_DETECTION        = 0x00000004,
    // 顔方向検出
    HVC_ACTIV_FACE_DIRECTION        = 0x00000008,
    // 年齢推定
    HVC_ACTIV_AGE_ESTIMATION        = 0x00000010,
    // 性別推定
    HVC_ACTIV_GENDER_ESTIMATION     = 0x00000020,
    // 視線推定
    HVC_ACTIV_GAZE_ESTIMATION       = 0x00000040,
    // 目つむり推定
    HVC_ACTIV_BLINK_ESTIMATION      = 0x00000080,
    // 表情推定
    HVC_ACTIV_EXPRESSION_ESTIMATION = 0x00000100,
};

//Gender
typedef NS_OPTIONS(NSInteger, HVC_GENDER){
    // Female
    HVC_GEN_FEMALE = 0,
    // Male
    HVC_GEN_MALE = 1,
};

// Expression
typedef NS_OPTIONS(NSInteger, HVC_EXPRESSION){
    // Neutral
    HVC_EX_NEUTRAL = 1,
    // Happiness
    HVC_EX_HAPPINESS = 2,
    // Surprise
    HVC_EX_SURPRISE = 3,
    // Anger
    HVC_EX_ANGER = 4,
    // Sadness
    HVC_EX_SADNESS = 5,
};


// Camera angle
typedef NS_OPTIONS(NSInteger,HVC_CAMERA_ANGLE){
    // 0 degree
    HVC_CAMERA_ANGLE_0 = 0,
    // 90 degree
    HVC_CAMERA_ANGLE_90 = 1,
    // 180 degree
    HVC_CAMERA_ANGLE_180 = 2,
    // 270 degree
    HVC_CAMERA_ANGLE_270 = 3,
} ;

// facial pose yaw angle
typedef NS_OPTIONS(NSInteger,HVC_FACE_POSE){
    // front
    HVC_FACE_POSE_FRONT = 0,
    // half profile
    HVC_FACE_POSE_HALF_PROFILE = 1,
    // profile
    HVC_FACE_POSE_PROFILE = 2,
} ;

// facial pose roll angle
typedef NS_OPTIONS(NSInteger,HVC_FACE_ANGLE){
    // 15 degree
    HVC_FACE_ANGLE_15 = 0,
    // 45 degree
    HVC_FACE_ANGLE_45 = 1,
} ;

// String length of Version
#define HVC_LEN_VERSIONSTRING       12

