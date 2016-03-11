//
//  UserSettings.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 23.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import "UserSettings.h"

@implementation UserSettings

int const    ALERT_RADIUS      = 10;
int const    SHOW_RADIUS       = 50;
int const    MAX_AGE           = 12;
double const DEFAULT_LATITUDE  = 55.75229644;
double const DEFAULT_LONGITUDE = 37.62273406;
bool const SHOW_ACCIDENTS = true;
bool const SHOW_BREAKS    = true;
bool const SHOW_STEALS    = true;
bool const SHOW_OTHERS    = true;
bool const SHOW_HEAVY     = true;
bool const SHOW_FINISHED  = true;

static int    alertRadius;
static int    showRadius;
static int    maxAge;
static double lon;
static double lat;
static bool   showAccidents;
static bool   showBreaks;
static bool   showSteals;
static bool   showOthers;
static bool   showHeavy;
static bool   showFinished;

static bool     anonymous;
static NSString *login;
static NSString *password;

static NSUserDefaults *settings;

+ (void)setup {
    settings      = [NSUserDefaults standardUserDefaults];
    alertRadius   = [settings valueForKey:@"alertRadius"] ? [settings integerForKey:@"alertRadius"] : ALERT_RADIUS;
    showRadius    = [settings valueForKey:@"showRadius"] ? [settings integerForKey:@"showRadius"] : SHOW_RADIUS;
    maxAge        = [settings valueForKey:@"maxAge"] ? [settings integerForKey:@"maxAge"] : MAX_AGE;
    lat           = [settings valueForKey:@"lat"] ? [settings integerForKey:@"lat"] : DEFAULT_LATITUDE;
    lon           = [settings valueForKey:@"lon"] ? [settings integerForKey:@"lon"] : DEFAULT_LONGITUDE;
    showAccidents = [settings valueForKey:@"showAccidents"] ? [settings boolForKey:@"showAccidents"] : SHOW_ACCIDENTS;
    showBreaks    = [settings valueForKey:@"showBreaks"] ? [settings boolForKey:@"showBreaks"] : SHOW_BREAKS;
    showSteals    = [settings valueForKey:@"showSteals"] ? [settings boolForKey:@"showSteals"] : SHOW_STEALS;
    showOthers    = [settings valueForKey:@"showOthers"] ? [settings boolForKey:@"showOthers"] : SHOW_OTHERS;
    showHeavy     = [settings valueForKey:@"showHeavy"] ? [settings boolForKey:@"showHeavy"] : SHOW_HEAVY;
    anonymous     = [settings valueForKey:@"anonymous"] ? [settings boolForKey:@"anonymous"] : NO;
    showFinished  = [settings valueForKey:@"showFinished"] ? [settings boolForKey:@"showFinished"] : SHOW_FINISHED;
    login         = [settings valueForKey:@"login"] ? [settings stringForKey:@"login"] : @"";
    password      = [settings valueForKey:@"password"] ? [settings stringForKey:@"password"] : @"";
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

+ (double)lat {
    return lat;
}

+ (double)lon {
    return lon;
}

+ (CLLocation *)location {
    return [[CLLocation alloc] initWithLatitude:lat longitude:lon];
}

+ (void)alertRadius:(int)radius {
    alertRadius = radius;
    [settings setInteger:alertRadius forKey:@"alertRadius"];
    [settings synchronize];
}

+ (void)showRadius:(int)radius {
    showRadius = radius;
    [settings setInteger:showRadius forKey:@"showRadius"];
    [settings synchronize];
}

+ (void)maxAge:(int)age {
    maxAge = age;
    [settings setInteger:maxAge forKey:@"maxAge"];
    [settings synchronize];
}

+ (void)showAccidents:(bool)visible {
    showAccidents = visible;
    [settings setBool:showAccidents forKey:@"showAccidents"];
    [settings synchronize];
}

+ (void)showBreaks:(bool)visible {
    showBreaks = visible;
    [settings setBool:showBreaks forKey:@"showBreaks"];
    [settings synchronize];
}

+ (void)showSteals:(bool)visible {
    showSteals = visible;
    [settings setBool:showSteals forKey:@"showSteals"];
    [settings synchronize];
}

+ (void)showOthers:(bool)visible {
    showOthers = visible;
    [settings setBool:showOthers forKey:@"showOthers"];
    [settings synchronize];
}

+ (void)showHeavy:(bool)visible {
    showHeavy = visible;
    [settings setBool:showHeavy forKey:@"showHeavy"];
    [settings synchronize];
}

+ (void)showFinished:(bool)visible {
    showHeavy = visible;
    [settings setBool:showHeavy forKey:@"showFinished"];
    [settings synchronize];
}

+ (void)anonymous:(bool)newAnonymous {
    anonymous = newAnonymous;
    [settings setBool:anonymous forKey:@"anonymous"];
    [settings synchronize];
}

+ (void)login:(NSString *)newLogin {
    login = newLogin;
    [settings setObject:login forKey:@"login"];
    [settings synchronize];
}

+ (void)password:(NSString *)newPassword {
    password = newPassword;
    [settings setObject:password forKey:@"password"];
    [settings synchronize];
}

+ (void)location:(CLLocation *)location {
    lat = location.coordinate.latitude;
    lon = location.coordinate.longitude;
    [settings setDouble:location.coordinate.latitude forKey:@"lat"];
    [settings setDouble:location.coordinate.longitude forKey:@"lon"];
    [settings synchronize];
}
@end
