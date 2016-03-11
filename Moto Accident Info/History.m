//
// Created by Громов Андрей on 04.01.16.
// Copyright (c) 2016 motoDTP. All rights reserved.
//

#import "History.h"


@implementation History {

}
- (instancetype)initWithJSONData:(NSDictionary *)data {
    self        = [super init];
    _idHistory  = [[data valueForKey:@"id"] intValue];
    _ownerId    = [[data valueForKey:@"id_user"] intValue];
    _isSelf     = NO;
    _noError    = YES;
    _owner      = [data valueForKey:@"owner"];
    _actionText = [data valueForKey:@"action"];
    _time       = (long) [data valueForKey:@"uxtime"];
    _status     = [HistoryStatus statusForString:[data valueForKey:@"action"]];
    return self;
}

- (NSComparisonResult)compare:(History *)object {
    if (_time < object.time)return NSOrderedAscending;
    if (_time > object.time)return NSOrderedDescending;
    return NSOrderedSame;
}
@end