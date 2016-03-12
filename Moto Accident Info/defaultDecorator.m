//
//  DefaultDecorator.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 18.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import "DefaultDecorator.h"
#import "ContentView.h"
#import "AccentLabel.h"
#import "MinorLabel.h"
#import "DistanceLabel.h"
#import "AgeLabel.h"
#import "FootnoteLabel.h"
#import "WizardButton.h"
#import "AccidentCell.h"
#import "EndedAccidentCell.h"
#import "MessageCell.h"
#import "OwnMessageCell.h"
#import "MessageCellWithoutOwner.h"

@implementation DefaultDecorator
static UIColor *defaultBackground;
static UIColor *defaultAccent;
static UIColor *inactiveColor;
static UIColor *distanceColor;
static UIColor *wizardButtonColor;


+ (void)initialize {
    defaultBackground = [UIColor colorWithRed:1.000 green:0.929 blue:0.855 alpha:1.00f];
    defaultAccent     = [UIColor colorWithRed:0.318 green:0.247 blue:0.576 alpha:1.00];
    inactiveColor     = [UIColor grayColor];
    distanceColor     = [UIColor colorWithRed:0.953 green:0.420 blue:0.275 alpha:1.00];
    wizardButtonColor = [UIColor colorWithRed:0.953 green:0.416 blue:0.275 alpha:1.00];
}

+ (void)setup {
    [ContentView appearance].backgroundColor             = defaultBackground;
    [AccidentCell appearance].backgroundColor            = defaultBackground;
    [EndedAccidentCell appearance].backgroundColor       = [UIColor colorWithRed:0.961 green:0.961 blue:0.961 alpha:1.00f];
    [MessageCell appearance].backgroundColor             = defaultBackground;
    [OwnMessageCell appearance].backgroundColor          = defaultBackground;
    [MessageCellWithoutOwner appearance].backgroundColor = defaultBackground;
    [UITableView appearance].backgroundColor             = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.0f];
    [AccentLabel appearance].textColor                   = defaultAccent;
    [MinorLabel appearance].textColor                    = inactiveColor;
    [DistanceLabel appearance].textColor                 = distanceColor;
    //[DistanceLabel appearance].font                      = [UIFont italicSystemFontOfSize:[UIFont systemFontSize] + 2];
    [AgeLabel appearance].textColor                      = defaultAccent;
    //[AgeLabel appearance].font                           = [UIFont italicSystemFontOfSize:[UIFont systemFontSize] + 2];
    [FootnoteLabel appearance].textColor                 = inactiveColor;
    [FootnoteLabel appearance].font                      = [UIFont systemFontOfSize:[UIFont systemFontSize] - 2];
    [WizardButton appearance].backgroundColor            = wizardButtonColor;
}

@end
