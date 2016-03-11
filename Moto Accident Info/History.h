//
// Created by Громов Андрей on 04.01.16.
// Copyright (c) 2016 motoDTP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryStatus.h"

@class HistoryStatus;


@interface History : NSObject
@property(nonatomic) int idHistory;

@property(nonatomic) int ownerId;

@property(nonatomic, copy) NSString *owner;

@property(nonatomic, copy) NSString *actionText;

@property(nonatomic) long time;

@property(nonatomic, assign) enum HistoryStatus status;

@property(nonatomic) bool noError;

@property(nonatomic) bool isSelf;

- (instancetype)initWithJSONData:(NSDictionary *)data;

- (NSComparisonResult)compare:(History *)object;
@end