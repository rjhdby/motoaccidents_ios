//
// Created by Громов Андрей on 18.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HTTPResponse : NSObject
- (instancetype)initWith:(NSDictionary *)newResponse;

- (bool)hasError;

- (NSDictionary *)response;

- (NSString *)error;

- (NSString *)errorDescription;
@end