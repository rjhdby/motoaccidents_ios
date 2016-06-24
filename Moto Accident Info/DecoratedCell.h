//
// Created by Громов Андрей on 23.02.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

@protocol DecoratedCell <NSObject>
- (void)decorateWith:(id)object;

- (NSString *)getId;
@end