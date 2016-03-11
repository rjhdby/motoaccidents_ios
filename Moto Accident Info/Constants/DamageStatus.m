//
// Created by Громов Андрей on 16.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import "DamageStatus.h"


@implementation DamageStatus {

}
+ (enum DamageStatus)statusForString:(NSString *)name {
    if ([name isEqualToString:@"na"]) {
        return MS_UNKNOWN;
    } else if ([name isEqualToString:@"wo"]) {
        return MS_NONE;
    } else if ([name isEqualToString:@"l"]) {
        return MS_LIGHT;
    } else if ([name isEqualToString:@"h"]) {
        return MS_HEAVY;
    } else if ([name isEqualToString:@"d"]) {
        return MS_LETHAL;
    } else {
        return MS_UNKNOWN;
    }
}

+ (NSString *)codeForStatus:(enum DamageStatus)status {
    if (status == MS_UNKNOWN) {
        return @"na";
    } else if (status == MS_NONE) {
        return @"wo";
    } else if (status == MS_LIGHT) {
        return @"l";
    } else if (status == MS_HEAVY) {
        return @"h";
    } else if (status == MS_LETHAL) {
        return @"d";
    } else {
        return @"na";
    }
}

+ (NSString *)stringForStatus:(enum DamageStatus)status {
    if (status == MS_UNKNOWN) {
        return @"Неизвестно";
    } else if (status == MS_NONE) {
        return @"Без травм";
    } else if (status == MS_LIGHT) {
        return @"Легкие";
    } else if (status == MS_HEAVY) {
        return @"Тяжелые";
    } else if (status == MS_LETHAL) {
        return @"Минус";
    } else {
        return @"Неизвестно";
    }
}
@end
