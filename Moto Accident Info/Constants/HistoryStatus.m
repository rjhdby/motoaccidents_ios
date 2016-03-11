//
// Created by Громов Андрей on 04.01.16.
// Copyright (c) 2016 motoDTP. All rights reserved.
//

#import "HistoryStatus.h"


@implementation HistoryStatus {

}

+ (enum HistoryStatus)statusForString:(NSString *)status {
    if ([status isEqualToString:@"create"]) {
        return H_CREATE;
    } else if ([status isEqualToString:@"act"]) {
        return H_OPEN;
    } else if ([status isEqualToString:@"end"]) {
        return H_CLOSE;
    } else if ([status isEqualToString:@"hide"]) {
        return H_HIDE;
    } else if ([status isEqualToString:@"ban"]) {
        return H_BAN;
    } else if ([status isEqualToString:@"cancel"]) {
        return H_CANCEL;
    } else if ([status isEqualToString:@"finish"]) {
        return H_FINISH;
    } else if ([status isEqualToString:@"inplace"]) {
        return H_IN_PLACE;
    } else if ([status isEqualToString:@"onway"]) {
        return H_ON_WAY;
    } else if ([status isEqualToString:@"leave"]) {
        return H_LEAVE;
    } else {
        return H_OTHER;
    }
}

+ (NSString *)stringForStatus:(enum HistoryStatus)status {
    switch (status) {
        case H_CREATE :
            return @"Создал";
        case H_OPEN :
            return @"Отмена отбоя";
        case H_CLOSE :
            return @"Отбой";
        case H_HIDE :
            return @"Скрыл";
        case H_BAN :
            return @"Бан";
        case H_CANCEL :
            return @"Отменил выезд";
        case H_FINISH :
            return @"Прочее";
        case H_IN_PLACE :
            return @"Приехал";
        case H_ON_WAY :
            return @"Выехал";
        case H_LEAVE :
            return @"Уехал";
        default        :
            return @"Прочее";
    }
}

@end