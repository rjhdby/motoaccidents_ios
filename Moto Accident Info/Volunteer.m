//
// Created by Громов Андрей on 04.01.16.
// Copyright (c) 2016 motoDTP. All rights reserved.
//

#import "Volunteer.h"

#pragma clang diagnostic push
#pragma ide diagnostic ignored "OCNotLocalizedStringInspection"

@implementation Volunteer {

}
- (instancetype)initWithJSONData:(NSDictionary *)data {
    self         = [super init];
    _idVolunteer = [[data valueForKey:@"id"] intValue];
    isSelf       = NO;
    noError      = YES;
    _name        = [data valueForKey:@"name"];
    _time        = (long) [data valueForKey:@"uxtime"];
    _status      = [VolunteerStatus statusForString:[data valueForKey:@"status"]];
    return self;
}

- (NSComparisonResult)compare:(Volunteer *)object {
    if (_time < object.time)return NSOrderedAscending;
    if (_time > object.time)return NSOrderedDescending;
    return NSOrderedSame;
}
@end

#pragma clang diagnostic pop