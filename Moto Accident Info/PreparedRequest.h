//
// Created by Громов Андрей on 18.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestMethod.h"

@interface PreparedRequest : NSObject

- (instancetype)initWithMethod:(enum RequestMethod)method;

- (instancetype)initWithMethod:(enum RequestMethod)method async:(bool)isAsync;

- (void)add:(NSString *)name value:(NSString *)value;

- (void)authRequired;

- (void)authWithLogin:(NSString *)login password:(NSString *)password;

- (NSDictionary *)build;

- (bool)isAsync;
@end