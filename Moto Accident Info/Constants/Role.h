//
//  Role.h
//  motoDTP
//
//  Created by Громов Андрей on 03.01.16.
//  Copyright (c) 2016 motoDTP. All rights reserved.
//

#import <Foundation/Foundation.h>
enum Role {
    ROLE_UNAUTHORIZED,
    ROLE_BANNED,
    ROLE_READONLY,
    ROLE_STANDARD,
    ROLE_MODERATOR,
    ROLE_ADMIN,
    ROLE_DEVELOPER,
    ROLE_ANONYMOUS
};
@interface Role : NSObject

+ (NSString *)stringForRole:(enum Role)role;

+ (enum Role)roleForString:(NSString *)role;
@end
