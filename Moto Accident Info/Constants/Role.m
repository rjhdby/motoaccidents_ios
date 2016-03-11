//
//  Role.m
//  motoDTP
//
//  Created by Громов Андрей on 03.01.16.
//  Copyright (c) 2016 motoDTP. All rights reserved.
//

#import "Role.h"

@implementation Role
+ (NSString *)stringForRole:(enum Role)role {
    switch (role) {
        case ROLE_BANNED:
            return @"Забанен";
        case ROLE_READONLY:
            return @"Только чтение";
        case ROLE_STANDARD:
            return @"Пользователь";
        case ROLE_MODERATOR:
            return @"Модератор";
        case ROLE_ADMIN:
            return @"Администратор";
        case ROLE_DEVELOPER:
            return @"Разработчик";
        case ROLE_ANONYMOUS:
            return @"Без авторизации";
        case ROLE_UNAUTHORIZED:
        default:
            return @"Не авторизован";
    }
}

+ (enum Role)roleForString:(NSString *)role {
    if ([role isEqual:@"r"]) {
        return ROLE_READONLY;
    } else if ([role isEqual:@"s"]) {
        return ROLE_STANDARD;
    } else if ([role isEqual:@"m"]) {
        return ROLE_MODERATOR;
    } else if ([role isEqual:@"d"]) {
        return ROLE_DEVELOPER;
    } else if ([role isEqual:@"a"]) {
        return ROLE_ADMIN;
    } else if ([role isEqual:@"b"]) {
        return ROLE_BANNED;
    } else return ROLE_UNAUTHORIZED;
}


@end
