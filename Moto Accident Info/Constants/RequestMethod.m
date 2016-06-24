//
// Created by Громов Андрей on 18.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import "RequestMethod.h"

#pragma clang diagnostic push
#pragma ide diagnostic ignored "OCNotLocalizedStringInspection"

@implementation RequestMethod {

}
+ (NSString *)method:(enum RequestMethod)method {
    if (method == R_AUTH) {
        return @"auth";
    } else if (method == R_LIST) {
        return @"list";
    } else if (method == R_NEW_ACCIDENT) {
        return @"acc";
    } else if (method == R_NEW_MESSAGE) {
        return @"comment";
    } else if (method == R_REGISTER_APNS) {
        return @"apns";
    } else if (method == R_ACCIDENT) {
        return @"getAccident";
    } else {
        return @"wrong";
    }
}
@end

#pragma clang diagnostic pop