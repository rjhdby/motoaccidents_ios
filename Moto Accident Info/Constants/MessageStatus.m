//
// Created by Громов Андрей on 04.01.16.
// Copyright (c) 2016 motoDTP. All rights reserved.
//

#import "MessageStatus.h"


@implementation MessageStatus {

}

+ (enum MessageStatus)statusForString:(NSString *)status {
    if ([status isEqualToString:@"h"]) {
        return MS_HIDDEN;
    } else {
        return MS_ACTIVE;
    }
}

+ (NSString *)stringForStatus:(enum MessageStatus)status {
    switch (status) {
        case MS_HIDDEN:
            return @"скрыто";
        default:
            return @"активно";
    }
}

+ (NSString *)codeForStatus:(enum MessageStatus)status {
    switch (status) {
        case MS_HIDDEN:
            return @"h";
        default:
            return @"a";
    }
}

@end