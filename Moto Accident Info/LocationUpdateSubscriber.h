//
// Created by Громов Андрей on 10.03.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;

@protocol LocationUpdateSubscriber <NSObject>

- (void)onLocationUpdate:(CLLocation *)newLocation;

- (void)subscribeForLocationUpdate;

- (void)revokeLocationUpdateSubscribe;
@end