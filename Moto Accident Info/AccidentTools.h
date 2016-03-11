//
// Created by Громов Андрей on 27.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AccidentTools : NSObject
+ (NSString *)simplifyAddress:(NSString *)input;

+ (NSString *)deduplicate:(NSString *)input;

+ (NSString *)formattedAge:(long)timestamp;

+ (NSString *)formattedDistance:(double)meters;
@end