//
// Created by Громов Андрей on 18.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import "HTTPResponse.h"


@implementation HTTPResponse {
    bool         hasError;
    NSDictionary *response;
    NSString     *error;
    NSString     *errorDescription;
}

- (instancetype)initWith:(NSDictionary *)newResponse {
    self     = [super init];
    response = [[NSDictionary alloc] init];
    if (newResponse[@"r"]) {
        if (newResponse[@"r"] == [NSNull null]) response = [[NSDictionary alloc] init];
        else response    = newResponse[@"r"];
        hasError         = false;
        error            = @"";
        errorDescription = @"";
    } else if (newResponse[@"e"]) {
        hasError         = true;
        error            = newResponse[@"e"];
        errorDescription = newResponse[@"d"];
    } else {
        hasError         = true;
        error            = @"UNKNOWN ERROR";
        errorDescription = @"";
    }
    return self;
}

- (bool)hasError {
    return hasError;
}

- (NSDictionary *)response {
    return response;
}

- (NSString *)error {
    return error;
}

- (NSString *)errorDescription {
    return errorDescription;
}


@end