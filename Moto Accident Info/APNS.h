//
//  APNS.h
//  Moto Accident Info
//
//  Created by Громов Андрей on 30.03.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APNS : NSObject

+ (void)tokenString:(NSData *)deviceToken;

+ (void)register;
@end
