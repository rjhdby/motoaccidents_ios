//
// Created by Громов Андрей on 16.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

enum RequestMethod {
    R_AUTH,
    R_LIST,
    R_NEW_ACCIDENT,
    R_NEW_MESSAGE
};

#import <Foundation/Foundation.h>


@interface RequestMethod : NSObject
+ (NSString *)method:(enum RequestMethod)method;
@end