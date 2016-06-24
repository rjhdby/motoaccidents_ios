//
//  Accident.m
//  motoDTP
//
//  Created by Громов Андрей on 04.01.16.
//  Copyright (c) 2016 motoDTP. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "Accident.h"
#import "Message.h"
#import "Volunteer.h"
#import "History.h"
#import "UserSettings.h"
#import "User.h"
#import "AccidentTools.h"
#import "LocationManager.h"

@implementation Accident

- (instancetype)initWithJSONData:(NSDictionary *)data {
    self = [super init];

    _timestamp  = [[data valueForKey:@"time"] longValue];
    _idAcc      = [[data valueForKey:@"id"] integerValue];
    _ownerId    = [[data valueForKey:@"oid"] integerValue];
    _location   = [[CLLocation alloc] initWithLatitude:[[data valueForKey:@"lat"] floatValue] longitude:[[data valueForKey:@"lon"] floatValue]];
    _isSelf     = NO;
    _owner      = (NSString *) [data valueForKey:@"o"];
    _address    = [AccidentTools deduplicate:[AccidentTools simplifyAddress:(NSString *) [data valueForKey:@"a"]]];
    _text       = (NSString *) [data valueForKey:@"d"];
    _time       = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval) _timestamp];
    _messages   = [NSMutableArray array];
    _history    = [NSMutableArray array];
    _volunteers = [NSMutableArray array];
    _type       = [AccidentType typeFromString:[data valueForKey:@"t"]];
    _damage     = [DamageStatus statusForString:[data valueForKey:@"med"]];
    _status     = [AccidentStatus statusForString:[data valueForKey:@"s"]];

    [self generateMessageArrayWith:[data valueForKey:@"m"]];
    [self generateVolunteerArrayWith:[data valueForKey:@"v"]];
    [self generateHistoryArrayWith:[data valueForKey:@"h"]];
    return self;
}

- (instancetype)initBlank {
    self = [super init];

    _timestamp  = (long) [[NSDate date] timeIntervalSince1970];
    _idAcc      = 0;
    _ownerId    = 0;
    _location   = [[LocationManager instance] current];
    _isSelf     = NO;
    _owner      = @"";
    _address    = @"";
    _text       = @"";
    _time       = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval) _timestamp];
    _messages   = [NSMutableArray array];
    _history    = [NSMutableArray array];
    _volunteers = [NSMutableArray array];
    _type       = AT_OTHER;
    _damage     = MS_UNKNOWN;
    _status     = AS_ACTIVE;
    return self;
}

- (void)generateMessageArrayWith:(NSDictionary *)newMessages {
    for (NSDictionary *newMessage in newMessages) {
        [_messages addObject:[[Message alloc] initWithJSONData:newMessage]];
    }
    [_messages sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
}

- (void)generateHistoryArrayWith:(NSDictionary *)newHistory {
    for (NSDictionary *newEvent in newHistory) {
        [_history addObject:[[History alloc] initWithJSONData:newEvent]];
    }
    [_history sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
}

- (void)generateVolunteerArrayWith:(NSDictionary *)newVolunteers {
    for (NSDictionary *newVolunteer in newVolunteers) {
        [_volunteers addObject:[[Volunteer alloc] initWithJSONData:newVolunteer]];
    }
    [_volunteers sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
}

- (NSString *)getTime {
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"dd.MM.yy HH:mm"];
    return [df stringFromDate:self.time];
}

- (NSString *)getAge {
    return [AccidentTools formattedAge:_timestamp];
}

- (NSString *)getDistanceFromUser {
    return [AccidentTools formattedDistance:[self distanceFromUser]];

}

- (double)distanceFromUser {
    return (double) [[[LocationManager instance] current] distanceFromLocation:_location];
}

- (Message *)getMessageById:(NSString *)msgId {
    for (Message *message in _messages) {
        if ([message.idMsg isEqual:@(msgId.intValue)])return message;
    }
    return nil;
}

- (bool)isVisible {
    if (_status == AS_HIDDEN && ![User isModerator])return NO;
    if (_status == AS_ENDED && !UserSettings.showFinished)return NO;
    if (_timestamp + UserSettings.maxAge * 3600 < [[NSDate date] timeIntervalSince1970])return NO;
    if ((_damage == MS_LETHAL || _damage == MS_HEAVY) && !UserSettings.showHeavy)return NO;
    if (_type == AT_BREAK && !UserSettings.showBreaks)return NO;
    if ([self isAccident] && !UserSettings.showAccidents)return NO;
    if (_type == AT_STEAL && !UserSettings.showSteals)return NO;
    if (_type == AT_OTHER && !UserSettings.showOthers)return NO;
    return [self distanceFromUser] / 1000 <= UserSettings.showRadius;
}

- (bool)willAlert {
    if (_status == AS_HIDDEN && ![User isModerator])return NO;
    if ((_damage == MS_LETHAL || _damage == MS_HEAVY) && !UserSettings.alertHeavy)return NO;
    if (_type == AT_BREAK && !UserSettings.alertBreaks)return NO;
    if ([self isAccident] && !UserSettings.alertAccidents)return NO;
    if (_type == AT_STEAL && !UserSettings.alertSteals)return NO;
    if (_type == AT_OTHER && !UserSettings.alertOthers)return NO;
    return [self distanceFromUser] / 1000 <= UserSettings.alertRadius;
}

- (bool)isAccident {
    return _type == AT_SOLO || _type == AT_MOTO_MAN || _type == AT_MOTO_AUTO || _type == AT_MOTO_MOTO;
}

- (NSComparisonResult)compare:(Accident *)object {
    if (_idAcc < object.idAcc)return NSOrderedAscending;
    if (_idAcc > object.idAcc)return NSOrderedDescending;
    return NSOrderedSame;
}

- (int)maxMessageId {
    if ([_messages count] == 0)return 0;
    return [[[_messages lastObject] idMsg] intValue];
}

@end