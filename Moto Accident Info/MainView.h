//
// Created by Громов Андрей on 04.03.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MainView <NSObject>
- (void)redraw;

- (void)updateData;

- (void)onLocationUpdate;
@end