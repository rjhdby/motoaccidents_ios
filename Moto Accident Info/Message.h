//
// Created by Громов Андрей on 04.01.16.
// Copyright (c) 2016 motoDTP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageStatus.h"

@class MessageStatus;


@interface Message : NSObject
@property(nonatomic) NSNumber                   *idMsg;
@property(nonatomic) int                        ownerId;
@property(nonatomic, copy) NSString             *owner;
@property(nonatomic, copy) NSString             *text;
@property(nonatomic) long                       time;
@property(nonatomic, assign) enum MessageStatus status;
@property(nonatomic) bool                       isSelf;

- (instancetype)initWithJSONData:(NSDictionary *)data;

- (NSComparisonResult)compare:(Message *)object;

@end