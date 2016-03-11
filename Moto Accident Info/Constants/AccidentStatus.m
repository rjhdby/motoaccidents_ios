//
// Created by Громов Андрей on 27.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import "AccidentStatus.h"


@implementation AccidentStatus {

}
+ (enum AccidentStatus)statusForString:(NSString *)name {
    if ([name isEqualToString:@"a"]) {
        return AS_ACTIVE;
    } else if ([name isEqualToString:@"e"]) {
        return AS_ENDED;
    } else if ([name isEqualToString:@"d"]) {
        return AS_DOUBLE;
    } else if ([name isEqualToString:@"h"]) {
        return AS_HIDDEN;
    } else if ([name isEqualToString:@"c"]) {
        return AS_CONFLICT;
    } else {
        return AS_ACTIVE;
    }
}

+ (NSString *)codeForStatus:(enum AccidentStatus)status {
    switch (status) {
        case AS_ACTIVE:
            return @"a";
        case AS_ENDED:
            return @"e";
        case AS_HIDDEN:
            return @"h";
        case AS_DOUBLE:
            return @"d";
        case AS_CONFLICT:
            return @"c";
        default:
            return @"a";
    }
}
@end