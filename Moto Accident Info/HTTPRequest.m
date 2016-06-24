//
//  ServerRequest.m
//  motoDTP
//
//  Created by Громов Андрей on 03.01.16.
//  Copyright (c) 2016 motoDTP. All rights reserved.
//

#import "HTTPRequest.h"
#import "PreparedRequest.h"
#import "HTTPResponse.h"

@implementation HTTPRequest
NSString *const ServerURL = @"http://apk.moto.msk.ru/request.php";

bool async;

- (instancetype)initWithRequest:(PreparedRequest *)request {
    args  = [request build];
    async = [request isAsync];
    return self;
}

- (NSString *)prepareURL {
    NSString *serverAddress = [NSString stringWithFormat:@"%@?", ServerURL];

    for (NSString *key in args) {
        serverAddress = [NSString stringWithFormat:@"%@%@=%@&", serverAddress, key, args[key]];
    }
    //NSLog(serverAddress);
    return serverAddress;
}

- (NSString *)decodeResponse:(NSData *)response {
    NSString *responseData = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];

    NSString *convertedString = [responseData mutableCopy];

    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef) convertedString, NULL, transform, YES);
    //NSLog(convertedString);
    return convertedString;
}

- (HTTPResponse *)execute {
    if (async) {
        //TODO ASYNC
        return [[HTTPResponse alloc] initWith:[self syncRequest]];
    } else {
        return [[HTTPResponse alloc] initWith:[self syncRequest]];
    }
}


- (NSDictionary *)syncRequest {
    NSMutableURLRequest *request =
                                [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:[self prepareURL]]
                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                       timeoutInterval:10
                                ];

    [request setHTTPMethod:@"GET"];
    NSError       *requestError = nil;
    NSURLResponse *urlResponse  = nil;
    NSData        *response     = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    NSData        *jsonData     = [[self decodeResponse:response] dataUsingEncoding:NSUTF8StringEncoding];
    NSError       *jsonError;
    NSDictionary  *dict         = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&jsonError];
   // NSLog(@"%@", [self prepareURL]);
   // NSLog(@"%@", dict);
    return dict;
}

@end
