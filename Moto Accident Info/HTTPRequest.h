//
//  ServerRequest.h
//  motoDTP
//
//  Created by Громов Андрей on 03.01.16.
//  Copyright (c) 2016 motoDTP. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PreparedRequest;
@class HTTPResponse;

@interface HTTPRequest : NSObject {
    NSDictionary  *args;
}
- (instancetype)initWithRequest:(PreparedRequest *)request;

- (HTTPResponse *)execute;
@end
