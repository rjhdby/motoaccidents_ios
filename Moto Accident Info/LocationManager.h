//
// Created by Громов Андрей on 28.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol MainView;
@protocol LocationUpdateSubscriber;

@interface LocationManager : NSObject <CLLocationManagerDelegate>
@property(strong, nonatomic) CLLocation        *current;
@property(strong, nonatomic) CLLocationManager *locationManager;

+ (LocationManager *)instance;

- (void)setBest;

- (void)setCoarse;

- (CLLocation *)current;


+ (void)subscribe:(NSObject <LocationUpdateSubscriber> *)subscriber name:(NSString *)name;

+ (void)revokeSubscription:(NSString *)name;

@end