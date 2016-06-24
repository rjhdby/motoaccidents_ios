//
//  UserSettings.h
//  Moto Accident Info
//
//  Created by Громов Андрей on 23.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface UserSettings : NSObject
+ (void)setup;

+ (CLLocation *)location;

+ (int)alertRadius;

+ (int)showRadius;

+ (int)maxAge;

+ (bool)alertAccidents;

+ (bool)alertBreaks;

+ (bool)alertSteals;

+ (bool)alertOthers;

+ (bool)alertHeavy;

+ (bool)showAccidents;

+ (bool)showBreaks;

+ (bool)showSteals;

+ (bool)showOthers;

+ (bool)showHeavy;

+ (bool)showFinished;

+ (bool)anonymous;

+ (NSString *)login;

+ (NSString *)password;

+ (void)alertRadius:(int)radius;

+ (void)showRadius:(int)radius;

+ (void)maxAge:(int)age;

+ (void)showAccidents:(bool)visible;

+ (void)showBreaks:(bool)visible;

+ (void)showSteals:(bool)visible;

+ (void)showOthers:(bool)visible;

+ (void)showHeavy:(bool)visible;

+ (void)showFinished:(bool)visible;

+ (void)alertAccidents:(bool)value;

+ (void)alertBreaks:(bool)value;

+ (void)alertSteals:(bool)value;

+ (void)alertOthers:(bool)value;

+ (void)alertHeavy:(bool)value;

+ (void)anonymous:(bool)newAnonymous;

+ (void)login:(NSString *)newLogin;

+ (void)password:(NSString *)newPassword;

+ (void)location:(CLLocation *)location;
@end
