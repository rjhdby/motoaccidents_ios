//
// Created by Громов Андрей on 28.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import "LocationManager.h"
#import "UserSettings.h"
#import "LocationUpdateSubscriber.h"


@implementation LocationManager {

}
static NSMutableDictionary *subscribers;

+ (LocationManager *)instance {
    static LocationManager *instance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });

    return instance;
}

- (id)init {
    if (self != nil) {
        self             = [super init];
        _current         = UserSettings.location;
        _locationManager = [[CLLocationManager alloc] init];
        subscribers      = [[NSMutableDictionary alloc] init];
        _locationManager.delegate = self;
    }
    return self;
}

- (void)setBest {
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestAlwaysAuthorization];
    }
    [_locationManager startUpdatingLocation];
}

- (void)setCoarse {

    _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestAlwaysAuthorization];
    }
    [_locationManager startUpdatingLocation];
}

- (CLLocation *)current {
    if (![CLLocationManager locationServicesEnabled]) return UserSettings.location;
    return _current;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    _current = UserSettings.location;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    _current = locations[0];
    [UserSettings location:_current];
    for (NSObject <LocationUpdateSubscriber> *subscriber in subscribers) {
        [subscribers[subscriber] onLocationUpdate:_current];
    }
}

+ (void)subscribe:(NSObject <LocationUpdateSubscriber> *)subscriber name:(NSString *)name {
    subscribers[name] = subscriber;
}

+ (void)revokeSubscription:(NSString *)name {
    [subscribers removeObjectForKey:name];
}
@end