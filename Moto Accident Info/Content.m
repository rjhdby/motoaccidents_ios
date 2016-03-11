//
//  Content.m
//  motoDTP
//
//  Created by Громов Андрей on 04.01.16.
//  Copyright (c) 2016 motoDTP. All rights reserved.
//

#import "Content.h"
#import "Accident.h"
#import "PreparedRequest.h"
#import "HTTPResponse.h"
#import "HTTPRequest.h"
#import "User.h"
#import "UserSettings.h"

@implementation Content
static NSMutableDictionary *accidents;
static NSMutableDictionary *readComments;

static NSString *readCommentsPath;

+ (void)setup {
    NSArray  *paths              = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];

    readCommentsPath = [documentsDirectory stringByAppendingPathComponent:@"readComments.plist"];
    [self prepareReadComments];
}

+ (void)update {
    PreparedRequest *request = [[PreparedRequest alloc] initWithMethod:R_LIST];
    //TODO Use settings and real location
    [request add:@"lon" value:@"37.62273406982422"];
    [request add:@"lat" value:@"55.752296447753906"];
    [request add:@"h" value:[NSString stringWithFormat:@"%i", [UserSettings maxAge]]];
    if ([User isAuthorized]) {
        [request add:@"l" value:[UserSettings login]];
    }
    HTTPResponse *response = [[[HTTPRequest alloc] initWithRequest:request] execute];
    if ([response hasError]) {
        //TODO Popup message
    } else {
        [self updateContentWithJSONData:[response response]];
    }
}

+ (void)updateContentWithJSONData:(NSDictionary *)data {
    if (accidents == nil) {
        accidents = [[NSMutableDictionary alloc] init];
    }
    for (NSDictionary *object in data) {
        Accident *accident = [[Accident alloc] initWithJSONData:object];
        accidents[@([object[@"id"] intValue])] = accident;
    }
}

+ (NSArray *)visibleAccidents {
    NSMutableArray *ids = [NSMutableArray array];
    for (NSNumber  *idAcc in accidents) {
        if ([accidents[idAcc] isVisible])[ids addObject:accidents[idAcc]];
    }
    [ids sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return -[obj1 compare:obj2];
    }];
    return ids;
}

+ (NSArray *)messagesFromAccident:(NSNumber *)accidentId {
    NSMutableArray *messages = [accidents[accidentId] messages];
    [messages sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    return messages;
}

+ (Accident *)getById:(NSString *)idAcc {
    if (idAcc == nil)return [[Accident alloc] initBlank];
    if (accidents[@([idAcc integerValue])] == nil) return [[Accident alloc] initBlank];
    return accidents[@([idAcc integerValue])];
}

+ (void)prepareReadComments {

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:readCommentsPath]) {
        readComments = [[NSMutableDictionary alloc] initWithContentsOfFile:readCommentsPath];
    } else {
        readComments = [[NSMutableDictionary alloc] init];
    }
}

+ (void)setLastReadForAccidentId:(int)idAcc {
    if ([[(Accident *) accidents[@(idAcc)] messages] count] == 0)return;
    readComments[[NSString stringWithFormat:@"%@", @(idAcc)]] = @([(Accident *) accidents[@(idAcc)] maxMessageId]);
    [readComments writeToFile:readCommentsPath atomically:YES];
}

+ (bool)hasUndeadForAccident:(Accident *)accident {
    if ([accident.messages count] == 0)return NO;
    if (!readComments[[NSString stringWithFormat:@"%i", accident.idAcc]])return YES;
    return [accident maxMessageId] > [readComments[[NSString stringWithFormat:@"%i", accident.idAcc]] intValue];
}
@end
