//
// Created by Громов Андрей on 16.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//
#import <Foundation/Foundation.h>

enum DamageStatus {
    MS_UNKNOWN,
    MS_NONE,
    MS_LIGHT,
    MS_HEAVY,
    MS_LETHAL,
    BS_TOOLS,
    BS_GASOLINE,
    BS_TIRE,
    BS_BATTERY,
    BS_OTHER
};

@interface DamageStatus : NSObject
+ (enum DamageStatus)statusForString:(NSString *)name;

+ (NSString *)codeForStatus:(enum DamageStatus)status;

+ (NSString *)stringForStatus:(enum DamageStatus)status;
@end