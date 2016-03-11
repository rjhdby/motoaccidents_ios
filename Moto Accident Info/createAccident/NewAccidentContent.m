//
// Created by Громов Андрей on 16.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "NewAccidentContent.h"
#import "PreparedRequest.h"
#import "LocationManager.h"

@implementation NewAccidentContent {

}
static NSString          *address;
static NSString          *text;
static enum AccidentType accidentType;
static enum DamageStatus damage;
static CLLocation        *location;
static bool              statistic;
static bool              test;

+ (void)cleanUp {
    address      = @"";
    text         = @"";
    accidentType = AT_MOTO_AUTO;
    damage       = MS_UNKNOWN;
    location     = [[LocationManager instance] current];
    statistic    = NO;
    test         = NO;
}

+ (void)setType:(enum AccidentType)newType {
    if (accidentType == newType)
        return;
    accidentType = newType;
    if (newType == AT_BREAK) {
        damage = BS_TOOLS;
    } else {
        damage = MS_UNKNOWN;
    }
}

+ (void)setDamage:(enum DamageStatus)newDamage {
    damage = newDamage;
}

+ (void)setAddress:(NSString *)newAddress {
    address = newAddress;
}

+ (void)setText:(NSString *)newText {
    text = newText;
}

+ (void)setLocation:(CLLocation *)newLocation {
    location = newLocation;
}

+ (void)setStatistics:(bool)newStatistic {
    statistic = newStatistic;
}

+ (void)setTest:(bool)newTest {
    test = newTest;
}

+ (enum AccidentType)accidentType {
    return accidentType;
}

+ (enum DamageStatus)damage {
    return damage;
}

+ (NSString *)address {
    return address;
}

+ (NSString *)text {
    return text;
}

+ (bool)isStatistic {
    return statistic;
}

+ (bool)isTest {
    return test;
}

+(CLLocation *)location{
    return location;
}

+ (PreparedRequest *)request {
    PreparedRequest *request = [[PreparedRequest alloc] initWithMethod:R_NEW_ACCIDENT];
    [request authRequired];
    [request add:@"a" value:address];
    [request add:@"d" value:text];
    [request add:@"t" value:[AccidentType codeForType:accidentType]];
    [request add:@"c" value:[DamageStatus codeForStatus:damage]];
    [request add:@"lat" value:[NSString stringWithFormat:@"%f", [location coordinate].latitude]];
    [request add:@"lon" value:[NSString stringWithFormat:@"%f", [location coordinate].longitude]];
    if ([self isTest])[request add:@"test" value:@"1"];
    if ([self isStatistic])[request add:@"stat" value:@"1"];
    return request;
}

@end