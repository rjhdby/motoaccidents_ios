//
// Created by Громов Андрей on 27.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import "AccidentTools.h"


@implementation AccidentTools {

}
+ (NSString *)simplifyAddress:(NSString *)input {
    NSString *result = [input mutableCopy];
    result = [result stringByReplacingOccurrencesOfString:@"город " withString:@"г." options:NSCaseInsensitiveSearch range:(NSRange) {0, result.length}];
    result = [result stringByReplacingOccurrencesOfString:@"3-е транспортное кольцо" withString:@"ТТК" options:NSCaseInsensitiveSearch range:(NSRange) {0, result.length}];
    result = [result stringByReplacingOccurrencesOfString:@"улица" withString:@"ул." options:NSCaseInsensitiveSearch range:(NSRange) {0, result.length}];
    result = [result stringByReplacingOccurrencesOfString:@"дом " withString:@"д." options:NSCaseInsensitiveSearch range:(NSRange) {0, result.length}];
    result = [result stringByReplacingOccurrencesOfString:@"шоссе " withString:@"ш." options:NSCaseInsensitiveSearch range:(NSRange) {0, result.length}];
    result = [result stringByReplacingOccurrencesOfString:@"область " withString:@"обл." options:NSCaseInsensitiveSearch range:(NSRange) {0, result.length}];
    result = [result stringByReplacingOccurrencesOfString:@"г. москва" withString:@"Москва" options:NSCaseInsensitiveSearch range:(NSRange) {0, result.length}];

    return result;
}

+ (NSString *)deduplicate:(NSString *)input {
    NSRegularExpression *regex  = [NSRegularExpression regularExpressionWithPattern:@"(.+)\\s+(\\1)" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString            *result = [regex stringByReplacingMatchesInString:input options:0 range:NSMakeRange(0, [input length]) withTemplate:@"$1"];
    return result;
}

+ (NSString *)formattedAge:(long)timestamp {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    NSTimeInterval  current = [[NSDate date] timeIntervalSince1970];
    NSDate          *date   = [NSDate dateWithTimeIntervalSince1970:timestamp];
    int             minutes = (int) (current - timestamp) / 60;

    if (minutes < 60) {
        return [NSString stringWithFormat:@"%iм", minutes];
    }
    /*
    if (minutes < 180) {
        return [NSString stringWithFormat:@"%iч %iм", minutes / 60, minutes - (minutes / 60) * 60];
    }
     */
    if (minutes < 1440) {
        //return [NSString stringWithFormat:@"%iч", minutes / 60];
        [format setDateFormat:@"HH:mm"];
        return [format stringFromDate:date];
    }
    if (minutes < 259200) {
        [format setDateFormat:@"dd MMM"];
        return [format stringFromDate:date];
    }
    //return [NSString stringWithFormat:@"%iд", minutes / 1440];
    [format setDateFormat:@"dd.MM.yy"];
    return [format stringFromDate:date];
}

+ (NSString *)formattedDistance:(double)meters {
    if (meters > 900) {
        return [NSString stringWithFormat:@"%.1fкм", meters / 1000];
    } else {
        return [NSString stringWithFormat:@"%iм", (int) meters];
    }
}
@end