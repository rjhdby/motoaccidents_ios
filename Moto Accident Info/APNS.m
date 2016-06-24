//
//  APNS.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 30.03.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import "APNS.h"
#import "HTTPRequest.h"
#import "RequestMethod.h"
#import "PreparedRequest.h"
#import "User.h"

@implementation APNS
static NSString *token;

+ (void)tokenString:(NSData *)deviceToken {
    const char      *data     = [deviceToken bytes];
    NSMutableString *newToken = [NSMutableString string];

    for (NSUInteger i = 0; i < [deviceToken length]; i++) {
        [newToken appendFormat:@"%02.2hhX", data[i]];
    }
    token = newToken;
}

+ (void)register {
    if (token == nil || [User userId] == 0)return;
    PreparedRequest *request = [[PreparedRequest alloc] initWithMethod:R_REGISTER_APNS];
    [request add:@"k" value:token];
    [request add:@"id" value:[NSString stringWithFormat:@"%i", [User userId]]];
    HTTPResponse *response = [[[HTTPRequest alloc] initWithRequest:request] execute];
    NSLog(@"%@\n%@", request, response);
}
@end
