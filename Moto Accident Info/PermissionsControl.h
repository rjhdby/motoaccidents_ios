//
//  PermissionsControl.h
//  Moto Accident Info
//
//  Created by Громов Андрей on 22.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Accident;

@interface PermissionsControl : NSObject

+ (bool)canCreateAccident;

+ (bool)canWriteComment;

+ (bool)canFinishAccident:(Accident *)accident;

+ (bool)canHideAccident;

+ (bool)canCallAndReturn;

+ (bool)canCall;
@end
