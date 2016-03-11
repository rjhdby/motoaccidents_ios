//
// Created by Громов Андрей on 04.01.16.
// Copyright (c) 2016 motoDTP. All rights reserved.
//

#import "Message.h"


@implementation Message {

}
- (instancetype)initWithJSONData:(NSDictionary *)data {
    self     = [super init];
    _idMsg   = [data valueForKey:@"id"];
    _ownerId = [[data valueForKey:@"oid"] intValue];
    _isSelf  = NO;
    _owner   = [data valueForKey:@"o"];
    _text    = [data valueForKey:@"d"];
    _time    = [[data valueForKey:@"t"] longValue];
    _status  = [MessageStatus statusForString:[data valueForKey:@"s"]];
    return self;
}

- (NSComparisonResult)compare:(Message *)object {
    if (_time < object.time)return NSOrderedAscending;
    if (_time > object.time)return NSOrderedDescending;
    return NSOrderedSame;
}

@end