//
// Created by Громов Андрей on 04.01.16.
// Copyright (c) 2016 motoDTP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VolunteerStatus.h"

@interface Volunteer : NSObject {
    bool isSelf;
    bool noError;
}
@property(nonatomic) int idVolunteer;
@property(nonatomic, copy) NSString *name;
@property(nonatomic) long time;
@property(nonatomic, assign) enum VolunteerStatus status;

- (instancetype)initWithJSONData:(NSDictionary *)data;

- (NSComparisonResult)compare:(Volunteer *)object;
@end