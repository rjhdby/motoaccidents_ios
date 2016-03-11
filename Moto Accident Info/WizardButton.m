//
// Created by Громов Андрей on 06.03.16.
// Copyright (c) 2016 motoAccident. All rights reserved.
//

#import "WizardButton.h"


@implementation WizardButton {

}
- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [[self titleLabel] setFont:[UIFont fontWithName:@"ZegoeUI" size:18]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.layer.cornerRadius = self.frame.size.height / 2;
    }
    return self;
}
@end