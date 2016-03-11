//
// Created by Громов Андрей on 04.01.16.
// Copyright (c) 2016 motoDTP. All rights reserved.
//

#import <Foundation/Foundation.h>
enum HistoryStatus {
    H_CREATE,
    H_OPEN,
    H_CLOSE,
    H_HIDE,
    H_BAN,
    H_CANCEL,
    H_FINISH,
    H_IN_PLACE,
    H_ON_WAY,
    H_LEAVE,
    H_OTHER
};

@interface HistoryStatus : NSObject {

}

+ (enum HistoryStatus)statusForString:(NSString *)status;

+ (NSString *)stringForStatus:(enum HistoryStatus)status;
@end