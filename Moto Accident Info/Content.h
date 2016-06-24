//
//  Content.h
//  motoDTP
//
//  Created by Громов Андрей on 04.01.16.
//  Copyright (c) 2016 motoDTP. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Accident;

@interface Content : NSObject {
}
+ (void)setup;

+ (void)update;

+ (void)updateAccident:(NSString *)accId;

+ (void)updateContentWithJSONData:(NSDictionary *)data;

+ (NSArray *)visibleAccidents;

+ (NSArray *)messagesFromAccident:(NSNumber *)accidentId;

+ (Accident *)getById:(NSString *)idAcc;

+ (void)setLastReadForAccidentId:(int)idAcc;

+ (bool)hasUndeadForAccident:(Accident *)accident;

+ (int)toDetails;

+ (void)toDetails:(int)accId;
@end
