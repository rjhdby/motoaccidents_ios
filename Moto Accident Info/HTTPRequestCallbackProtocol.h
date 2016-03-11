//
// Created by Громов Андрей on 18.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTTPResponse;

@protocol HTTPRequestCallbackProtocol <NSObject>
- (void)onResult:(HTTPResponse *)response;

- (void)onError:(HTTPResponse *)response;;
@end