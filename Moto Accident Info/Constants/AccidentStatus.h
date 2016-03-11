//
// Created by Громов Андрей on 27.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import <Foundation/Foundation.h>
enum AccidentStatus {
    AS_ACTIVE,
    AS_ENDED,
    AS_HIDDEN,
    AS_DOUBLE,
    AS_CONFLICT
};

@interface AccidentStatus : NSObject
+ (enum AccidentStatus)statusForString:(NSString *)name;

+ (NSString *)codeForStatus:(enum AccidentStatus)status;
@end