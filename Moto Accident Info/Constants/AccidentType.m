//
// Created by Громов Андрей on 16.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import "AccidentType.h"

@implementation AccidentType {

}
+ (enum AccidentType)typeFromString:(NSString *)name {
    if ([name isEqualToString:@"b"]) {
        return AT_BREAK;
    } else if ([name isEqualToString:@"1"]) {
        return AT_SOLO;
    } else if ([name isEqualToString:@"m"]) {
        return AT_MOTO_MOTO;
    } else if ([name isEqualToString:@"a"]) {
        return AT_MOTO_AUTO;
    } else if ([name isEqualToString:@"p"]) {
        return AT_MOTO_MAN;
    } else if ([name isEqualToString:@"s"]) {
        return AT_STEAL;
    } else {
        return AT_OTHER;
    };
}

+ (NSString *)string:(enum AccidentType)type {
    switch (type) {
        case AT_BREAK:
            return @"Поломка";
        case AT_SOLO :
            return @"Один участник";
        case AT_MOTO_MOTO :
            return @"Мот/мот";
        case AT_MOTO_AUTO :
            return @"Мот/авто";
        case AT_MOTO_MAN :
            return @"Наезд на пешехода";
        case AT_STEAL :
            return @"Угон";
        case AT_OTHER :
        default:
            return @"Прочее";
    }
}

+ (NSString *)codeForType:(enum AccidentType)type {
    switch (type) {
        case AT_BREAK:
            return @"b";
        case AT_SOLO :
            return @"1";
        case AT_MOTO_MOTO :
            return @"m";
        case AT_MOTO_AUTO :
            return @"a";
        case AT_MOTO_MAN :
            return @"p";
        case AT_STEAL :
            return @"s";
        case AT_OTHER :
        default:
            return @"o";
    }
}
@end