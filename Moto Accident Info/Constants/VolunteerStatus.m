//
// Created by Громов Андрей on 16.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import "VolunteerStatus.h"


@implementation VolunteerStatus {

}
+ (enum VolunteerStatus)statusForString:(NSString *)name {
    if ([name isEqualToString:@"w"]) {
        return VS_ON_WAY;
    } else if ([name isEqualToString:@"l"]) {
        return VS_LEAVE;
    } else if ([name isEqualToString:@"i"]) {
        return VS_IN_PLACE;
    } else {
        return VS_UNKNOWN;
    }
}

- (NSString *)stringForStatus:(enum VolunteerStatus)status {
    if (status == VS_ON_WAY) {
        return @"В пути";
    } else if (status == VS_IN_PLACE) {
        return @"На месте";
    } else if (status == VS_LEAVE) {
        return @"Уехал";
    } else {
        return @"";
    }
}

- (NSString *)codeForStatus:(enum VolunteerStatus)status {
    if (status == VS_ON_WAY) {
        return @"w";
    } else if (status == VS_IN_PLACE) {
        return @"i";
    } else if (status == VS_LEAVE) {
        return @"l";
    } else {
        return @"";
    }
}
@end