//
// Created by Громов Андрей on 16.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

enum VolunteerStatus {
    VS_ON_WAY,
    VS_IN_PLACE,
    VS_LEAVE,
    VS_UNKNOWN
};

#import <Foundation/Foundation.h>


@interface VolunteerStatus : NSObject
+ (enum VolunteerStatus)statusForString:(NSString *)name;

- (NSString *)stringForStatus:(enum VolunteerStatus)status;

- (NSString *)codeForStatus:(enum VolunteerStatus)status;
@end