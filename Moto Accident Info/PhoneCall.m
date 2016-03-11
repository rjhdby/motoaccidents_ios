//
// Created by Громов Андрей on 04.03.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import "PhoneCall.h"
#import "PermissionsControl.h"


@implementation PhoneCall {

}
static NSString *const prefix         = @"tel://";
static NSString *const prefixFallback = @"telprompt://";

static NSString *const federalNumber = @"78007751734";

+ (void)call {
    if (![PermissionsControl canCall])return;
    [self callFederal];
}

+ (void)callFederal {
    [self makeCall:federalNumber];
}

+ (void)callLocal {

}

+ (void)makeCall:(NSString *)phone {
    NSURL *phoneUrl;

    if ([PermissionsControl canCallAndReturn]) {
        phoneUrl = [NSURL URLWithString:[prefixFallback stringByAppendingString:phone]];
    } else {
        phoneUrl = [NSURL URLWithString:[prefix stringByAppendingString:phone]];
    }
    [[UIApplication sharedApplication] openURL:phoneUrl];
}
@end