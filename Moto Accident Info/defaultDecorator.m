//
//  DefaultDecorator.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 18.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import "DefaultDecorator.h"
#import "ContentView.h"
#import "WizardButton.h"
#import "AccidentCell.h"
#import "EndedAccidentCell.h"
#import "MessageCell.h"
#import "OwnMessageCell.h"
#import "MessageCellWithoutOwner.h"
#import "CustomTextView.h"

@implementation DefaultDecorator
static UIColor *defaultBackground;
static UIColor *wizardButtonColor;
static CGRect  screenBounds;

+ (void)initialize {
    defaultBackground = [UIColor colorWithRed:1.000 green:0.929 blue:0.855 alpha:1.00f];
    wizardButtonColor = [UIColor colorWithRed:0.847 green:0.416 blue:0.263 alpha:1.00];
    screenBounds      = [[UIScreen mainScreen] bounds];
}

+ (void)setup {
    [ContentView appearance].backgroundColor             = defaultBackground;
    [AccidentCell appearance].backgroundColor            = defaultBackground;
    [EndedAccidentCell appearance].backgroundColor       = [UIColor colorWithRed:0.961 green:0.961 blue:0.961 alpha:1.00f];
    [MessageCell appearance].backgroundColor             = defaultBackground;
    [OwnMessageCell appearance].backgroundColor          = defaultBackground;
    [MessageCellWithoutOwner appearance].backgroundColor = defaultBackground;
    [UITableView appearance].backgroundColor             = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.0f];
    [WizardButton appearance].backgroundColor            = wizardButtonColor;
    [CustomTextView appearance].backgroundColor          = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
}

+ (CGFloat)screenWidth {
    return screenBounds.size.width;
}

+ (CGFloat)screenHeight {
    return screenBounds.size.height;
}
@end
