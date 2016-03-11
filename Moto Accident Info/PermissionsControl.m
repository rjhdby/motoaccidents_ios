//
//  PermissionsControl.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 22.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "PermissionsControl.h"
#import "User.h"
#import "Accident.h"

@implementation PermissionsControl

+ (bool)canCreateAccident {
    return [User isModerator] || (![User isReadOnly] && [CLLocationManager locationServicesEnabled]);
}

+ (bool)canWriteComment {
    return ![User isReadOnly];
}

+ (bool)canFinishAccident:(Accident *)accident {
    return [User isModerator] || ([User userId] == [accident ownerId]);
}

+ (bool)canHideAccident {
    return [User isModerator];
}

+ (bool)canCallAndReturn {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"telprompt://"]];
}

+ (bool)canCall {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
}
@end
