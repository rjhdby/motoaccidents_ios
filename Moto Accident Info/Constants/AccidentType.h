//
// Created by Громов Андрей on 16.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import <Foundation/Foundation.h>

enum AccidentType {
    AT_BREAK,
    AT_SOLO,
    AT_MOTO_MOTO,
    AT_MOTO_AUTO,
    AT_MOTO_MAN,
    AT_OTHER,
    AT_STEAL
};

@interface AccidentType : NSObject
+ (enum AccidentType)typeFromString:(NSString *)name;

+ (NSString *)string:(enum AccidentType)type;

+ (NSString *)codeForType:(enum AccidentType)type;
@end