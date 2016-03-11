//
//  User.h
//  motoDTP
//
//  Created by Громов Андрей on 03.01.16.
//  Copyright (c) 2016 motoDTP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Role.h"

@interface User : NSObject {
}
+ (void)setup;

+ (void)authWithLogin:(NSString *)login password:(NSString *)password;

+ (enum Role)role;

+ (int)userId;

+ (void)role:(enum Role)newRole;

+ (bool)isAuthorized;

+ (void)setAnonymousForever;

+ (void)setAnonymous;

+ (bool)isReadOnly;

+ (bool)isModerator;
@end
