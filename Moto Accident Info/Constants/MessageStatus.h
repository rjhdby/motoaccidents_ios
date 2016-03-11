//
// Created by Громов Андрей on 04.01.16.
// Copyright (c) 2016 motoDTP. All rights reserved.
//

#import <Foundation/Foundation.h>

enum MessageStatus {
    MS_HIDDEN,
    MS_ACTIVE
};
@interface MessageStatus : NSObject {

}

+ (enum MessageStatus)statusForString:(NSString *)status;

+ (NSString *)stringForStatus:(enum MessageStatus)status;

+ (NSString *)codeForStatus:(enum MessageStatus)status;
@end