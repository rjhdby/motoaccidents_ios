//
//  AppDelegate.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 25.01.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import "AppDelegate.h"
#import "LocationManager.h"
#import "DefaultDecorator.h"
#import "User.h"
#import "Content.h"
#import "APNS.h"
#import "Accident.h"
#import "UserSettings.h"
#import "AccidentType.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UserSettings setup];
    [User setup];
    [[LocationManager instance] setBest];
    [DefaultDecorator setup];
    [Content setup];
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)]) {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [application registerForRemoteNotifications];
    }
    else {
        // iOS < 8 Notifications
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
#pragma clang diagnostic pop
    }
    NSLog(@"%@", launchOptions);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[LocationManager instance] setCoarse];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[LocationManager instance] setBest];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [APNS tokenString:deviceToken];
    [APNS register];
    NSLog(@"Did Register for Remote Notifications with response (%@)", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Did Fail to Register for Remote Notifications");
    NSLog(@"%@, %@", error, error.localizedDescription);

}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    if (notification.userInfo[@"id"]) {
        [Content toDetails:[notification.userInfo[@"id"] intValue]];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    NSLog(@"%@", userInfo);
    
    NSString *id =  [userInfo[@"id"] stringValue];
    NSLog(@"id = %@", id);
    
    [Content updateAccident:id];
    Accident *acc = [Content getById:id];
    if ([acc willAlert]) {
        if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground) {
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[UIApplication sharedApplication] applicationIconBadgeNumber] + 1];
            UILocalNotification *localNotification = [[UILocalNotification alloc] init];
            localNotification.fireDate         = [[[NSDate alloc] init] dateByAddingTimeInterval:1];
            localNotification.alertAction      = [AccidentType string:acc.type];
            localNotification.alertBody        = acc.address;
            localNotification.alertLaunchImage = @"logo";
            localNotification.soundName        = UILocalNotificationDefaultSoundName;
            NSDictionary *infoDict = @{@"id" : [NSString stringWithFormat:@"%i", acc.idAcc]};
            localNotification.userInfo = infoDict;
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        }
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}
@end
