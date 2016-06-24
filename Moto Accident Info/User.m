//
//  User.m
//  motoDTP
//
//  Created by Громов Андрей on 03.01.16.
//  Copyright (c) 2016 motoDTP. All rights reserved.
//

#import "User.h"
#import "PreparedRequest.h"
#import "HTTPRequest.h"
#import "HTTPResponse.h"
#import "UserSettings.h"
#import "APNS.h"

@implementation User

static enum Role role   = ROLE_UNAUTHORIZED;
static int       userId = 0;

+ (void)setup {
    if (UserSettings.anonymous) {
        role = ROLE_ANONYMOUS;
    } else if (![UserSettings.login isEqualToString:@""] && ![UserSettings.password isEqualToString:@""]) {
        [User auth];
    }
}

+ (void)auth {
    [self authWithLogin:UserSettings.login password:UserSettings.password];
}

+ (void)authWithLogin:(NSString *)login password:(NSString *)password {
    PreparedRequest *request = [[PreparedRequest alloc] initWithMethod:R_AUTH];
    [request authWithLogin:login password:password];
    HTTPResponse *response = [[[HTTPRequest alloc] initWithRequest:request] execute];
    if ([response hasError])return;
    role   = [Role roleForString:[response response][@"r"]];
    userId = [[response response][@"id"] intValue];
    [UserSettings login:login];
    [UserSettings password:password];
    [APNS register];
}

+ (void)signOut {
    role   = ROLE_UNAUTHORIZED;
    userId = 0;
    [UserSettings login:@""];
    [UserSettings password:@""];
    [UserSettings anonymous:NO];
}

+ (enum Role)role {
    return role;
}

+ (int)userId {
    return userId;
}

+ (void)role:(enum Role)newRole {
    role = newRole;
}

+ (bool)isAuthorized {
    return !(role == ROLE_UNAUTHORIZED || role == ROLE_ANONYMOUS);
}

+ (void)setAnonymousForever {
    role = ROLE_ANONYMOUS;
    [UserSettings anonymous:YES];
}

+ (bool)isAnonymousForever {
    return UserSettings.anonymous;
}

+ (void)setAnonymous {
    role = ROLE_ANONYMOUS;
}

+ (bool)isReadOnly {
    return role == ROLE_READONLY || role == ROLE_ANONYMOUS || role == ROLE_UNAUTHORIZED || role == ROLE_BANNED;
}

+ (bool)isModerator {
    return role == ROLE_MODERATOR || role == ROLE_ADMIN || role == ROLE_DEVELOPER;
}
@end
