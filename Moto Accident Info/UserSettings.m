//
//  UserSettings.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 23.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "UserSettings.h"

@implementation UserSettings

double const DEFAULT_LATITUDE  = 55.75229644;
double const DEFAULT_LONGITUDE = 37.62273406;

static int        alertRadius;
static int        showRadius;
static int        maxAge;
static bool       showAccidents;
static bool       showBreaks;
static bool       showSteals;
static bool       showOthers;
static bool       showHeavy;
static bool       alertAccidents;
static bool       alertBreaks;
static bool       alertSteals;
static bool       alertOthers;
static bool       alertHeavy;
static bool       showFinished;
static bool       anonymous;
static NSString   *login;
static NSString   *password;
static CLLocation *location;

+ (void)setup {
    alertRadius    = [UserSettings getInt:@"alertRadius" defaultValue:10];
    showRadius     = [UserSettings getInt:@"showRadius" defaultValue:50];
    maxAge         = [UserSettings getInt:@"maxAge" defaultValue:12];
    showAccidents  = [UserSettings getBool:@"showAccidents" defaultValue:YES];
    showBreaks     = [UserSettings getBool:@"showBreaks" defaultValue:YES];
    showSteals     = [UserSettings getBool:@"showSteals" defaultValue:YES];
    showOthers     = [UserSettings getBool:@"showOthers" defaultValue:YES];
    showHeavy      = [UserSettings getBool:@"showHeavy" defaultValue:YES];
    alertAccidents = [UserSettings getBool:@"alertAccidents" defaultValue:YES];
    alertBreaks    = [UserSettings getBool:@"alertBreaks" defaultValue:YES];
    alertSteals    = [UserSettings getBool:@"alertSteals" defaultValue:YES];
    alertOthers    = [UserSettings getBool:@"alertOthers" defaultValue:YES];
    alertHeavy     = [UserSettings getBool:@"alertHeavy" defaultValue:YES];
    showFinished   = [UserSettings getBool:@"showFinished" defaultValue:YES];
    anonymous      = [UserSettings getBool:@"anonymous" defaultValue:NO];
    login          = [UserSettings getString:@"login" defaultValue:@""];
    password       = [UserSettings getString:@"password" defaultValue:@""];
    location       = [UserSettings getLocation];
}

+ (CLLocation *)location {
    return location;
}

+ (int)alertRadius {
    return alertRadius;
}

+ (int)showRadius {
    return showRadius;
}

+ (int)maxAge {
    return maxAge;
}

+ (bool)alertAccidents {
    return alertAccidents;
}

+ (bool)alertBreaks {
    return alertBreaks;
}

+ (bool)alertSteals {
    return alertSteals;
}

+ (bool)alertOthers {
    return alertOthers;
}

+ (bool)alertHeavy {
    return alertHeavy;
}

+ (bool)showAccidents {
    return showAccidents;
}

+ (bool)showBreaks {
    return showBreaks;
}

+ (bool)showSteals {
    return showSteals;
}

+ (bool)showOthers {
    return showOthers;
}

+ (bool)showHeavy {
    return showHeavy;
}

+ (bool)showFinished {
    return showFinished;
}

+ (bool)anonymous {
    return anonymous;
}

+ (NSString *)login {
    return login;
}

+ (NSString *)password {
    return password;
}

//- setters ----------------------------------------------
+ (void)alertRadius:(int)value {
    alertRadius = value;
    [UserSettings setInt:@"alertRadius" value:value];
}

+ (void)showRadius:(int)value {
    showRadius = value;
    [UserSettings setInt:@"showRadius" value:value];
}

+ (void)maxAge:(int)value {
    maxAge = value;
    [UserSettings setInt:@"maxAge" value:value];
}

+ (void)showAccidents:(bool)value {
    showAccidents = value;
    [UserSettings setBool:@"showAccidents" value:value];
}

+ (void)showBreaks:(bool)value {
    showBreaks = value;
    [UserSettings setBool:@"showBreaks" value:value];
}

+ (void)showSteals:(bool)value {
    showSteals = value;
    [UserSettings setBool:@"showSteals" value:value];
}

+ (void)showOthers:(bool)value {
    showOthers = value;
    [UserSettings setBool:@"showOthers" value:value];
}

+ (void)showHeavy:(bool)value {
    showHeavy = value;
    [UserSettings setBool:@"showHeavy" value:value];
}

+ (void)showFinished:(bool)value {
    showFinished = value;
    [UserSettings setBool:@"showFinished" value:value];
}

+ (void)alertAccidents:(bool)value {
    alertAccidents = value;
    [UserSettings setBool:@"alertAccidents" value:value];
}

+ (void)alertBreaks:(bool)value {
    alertBreaks = value;
    [UserSettings setBool:@"alertBreaks" value:value];
}

+ (void)alertSteals:(bool)value {
    alertSteals = value;
    [UserSettings setBool:@"alertSteals" value:value];
}

+ (void)alertOthers:(bool)value {
    alertOthers = value;
    [UserSettings setBool:@"alertOthers" value:value];
}

+ (void)alertHeavy:(bool)value {
    alertHeavy = value;
    [UserSettings setBool:@"alertHeavy" value:value];
}

+ (void)anonymous:(bool)value {
    anonymous = value;
    [UserSettings setBool:@"anonymous" value:value];
}

+ (void)login:(NSString *)value {
    login = value;
    [UserSettings setString:@"login" value:value];
}

+ (void)password:(NSString *)value {
    password = value;
    [UserSettings setString:@"password" value:value];
}

+ (void)location:(CLLocation *)value {
    [UserSettings setDouble:@"lat" value:location.coordinate.latitude];
    [UserSettings setDouble:@"lon" value:location.coordinate.longitude];
    location = value;
}

//- internal ----------------------------------------------
+ (int)getInt:(NSString *)key defaultValue:(int)defaultValue {
    return [[NSUserDefaults standardUserDefaults] valueForKey:key] ? [[NSUserDefaults standardUserDefaults] integerForKey:key] : defaultValue;
}

+ (double)getDouble:(NSString *)key defaultValue:(double)defaultValue {
    return [[NSUserDefaults standardUserDefaults] valueForKey:key] ? [[NSUserDefaults standardUserDefaults] doubleForKey:key] : defaultValue;
}

+ (CLLocation *)getLocation {
    double lat = [UserSettings getDouble:@"lat" defaultValue:DEFAULT_LATITUDE];
    double lon = [UserSettings getDouble:@"lon" defaultValue:DEFAULT_LONGITUDE];
    return [[CLLocation alloc] initWithLatitude:lat longitude:lon];
}

+ (bool)getBool:(NSString *)key defaultValue:(bool)defaultValue {
    return [[NSUserDefaults standardUserDefaults] valueForKey:key] ? [[NSUserDefaults standardUserDefaults] boolForKey:key] : defaultValue;
}

+ (NSString *)getString:(NSString *)key defaultValue:(NSString *)defaultValue {
    return [[NSUserDefaults standardUserDefaults] valueForKey:key] ? [[NSUserDefaults standardUserDefaults] stringForKey:key] : defaultValue;
}

+ (void)setInt:(NSString *)key value:(int)value {
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setBool:(NSString *)key value:(bool)value {
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setString:(NSString *)key value:(NSObject *)value {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setDouble:(NSString *)key value:(double)value {
    [[NSUserDefaults standardUserDefaults] setDouble:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
