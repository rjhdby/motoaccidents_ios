//
//  Accident.h
//  motoDTP
//
//  Created by Громов Андрей on 04.01.16.
//  Copyright (c) 2016 motoDTP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccidentType.h"
#import "DamageStatus.h"
#import "AccidentStatus.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@class CLLocation;
@class Message;
@class AccidentStatus;

@interface Accident : NSObject

@property(nonatomic) int                         ownerId;
@property(nonatomic) CLLocation*      location;
@property(nonatomic, copy) NSString              *owner;
@property(nonatomic, copy) NSString              *address;
@property(nonatomic, copy) NSString              *text;
@property(nonatomic, strong) NSDate              *time;
@property(nonatomic, assign) enum AccidentType   type;
@property(nonatomic, assign) enum DamageStatus   damage;
@property(nonatomic) int                         idAcc;
@property(nonatomic) bool                        isSelf;
@property(nonatomic) long                        timestamp;
@property(nonatomic, strong) NSMutableArray      *messages;
@property(nonatomic, strong) NSMutableArray      *history;
@property(nonatomic, strong) NSMutableArray      *volunteers;
@property(nonatomic, assign) enum AccidentStatus status;

- (instancetype)initWithJSONData:(NSDictionary *)data;

- (instancetype)initBlank;

- (NSString *)getTime;

- (NSString *)getAge;

- (NSString *)getDistanceFromUser;

- (bool)isVisible;

- (bool)isAccident;

- (NSComparisonResult)compare:(Accident *)object;

- (int)maxMessageId;
@end
