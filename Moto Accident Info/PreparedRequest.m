//
// Created by Громов Андрей on 18.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import "PreparedRequest.h"
#import "UserSettings.h"
#import "MD5.h"


@implementation PreparedRequest {
    NSMutableDictionary *request;
    NSObject            *callback;
    bool async;
}

- (instancetype)initWithMethod:(enum RequestMethod)method {
    return [self initWithMethod:method async:false callback:nil];
}

- (instancetype)initWithMethod:(enum RequestMethod)method async:(bool)isAsync {
    return [self initWithMethod:method async:isAsync callback:nil];
}

- (instancetype)initWithMethod:(enum RequestMethod)method async:(bool)isAsync callback:(id)newCallback {
    self    = [super init];
    request = [[NSMutableDictionary alloc] init];
    request[@"m"] = [RequestMethod method:method];
    async    = isAsync;
    callback = newCallback;
    return self;
}

- (void)add:(NSString *)name value:(NSString *)value {
    request[name] = [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
}

- (void)authRequired {
    request[@"l"] = [[UserSettings login] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    request[@"p"] = [[UserSettings password] md5];
}

- (void)authWithLogin:(NSString *)login password:(NSString *)password {
    request[@"l"] = [login stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    request[@"p"] = [password md5];
}

- (NSDictionary *)build {
    return request;
}

- (bool)isAsync {
    return async;
}
@end