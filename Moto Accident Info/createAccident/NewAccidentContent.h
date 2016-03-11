//
// Created by Громов Андрей on 16.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccidentType.h"
#import "DamageStatus.h"

@class CLLocation;
@class PreparedRequest;

@interface NewAccidentContent : NSObject
+ (void)cleanUp;

+ (void)setType:(enum AccidentType)newType;

+ (void)setDamage:(enum DamageStatus)newDamage;

+ (void)setAddress:(NSString *)newAddress;

+ (void)setText:(NSString *)newText;

+ (void)setLocation:(CLLocation *)newLocation;

+ (void)setStatistics:(bool)newStatistic;

+ (void)setTest:(bool)newTest;

+ (enum AccidentType)accidentType;

+ (enum DamageStatus)damage;

+ (NSString *)address;

+ (NSString *)text;

+ (bool)isStatistic;

+ (bool)isTest;

+ (CLLocation *)location;

+ (PreparedRequest *)request;
@end