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

@implementation DefaultDecorator
static UIColor *defaultBackground;
static UIColor *defaultAccent;
static UIColor *inactiveColor;
static UIColor *distanceColor;
static UIColor *wizardButtonColor;


+ (void)initialize {
    defaultBackground = [UIColor colorWithRed:1 green:0.93 blue:0.85 alpha:1];
    defaultAccent     = [UIColor colorWithRed:0.318 green:0.247 blue:0.576 alpha:1.00];
    inactiveColor     = [UIColor grayColor];
    distanceColor     = [UIColor colorWithRed:0.953 green:0.420 blue:0.275 alpha:1.00];
    wizardButtonColor = [UIColor colorWithRed:0.953 green:0.416 blue:0.275 alpha:1.00];
}

+ (void)setup {
    [ContentView appearance].backgroundColor     = defaultBackground;
    [UITableViewCell appearance].backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.0f];
    [UITableView appearance].backgroundColor     = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5f];
    [AccentLabel appearance].textColor           = defaultAccent;
    [MinorLabel appearance].textColor            = inactiveColor;
    [DistanceLabel appearance].textColor         = distanceColor;
    [DistanceLabel appearance].font              = [UIFont italicSystemFontOfSize:[UIFont systemFontSize] + 2];
    [AgeLabel appearance].textColor              = defaultAccent;
    [AgeLabel appearance].font                   = [UIFont italicSystemFontOfSize:[UIFont systemFontSize] + 2];
    [FootnoteLabel appearance].textColor         = inactiveColor;
    [FootnoteLabel appearance].font              = [UIFont systemFontOfSize:[UIFont systemFontSize] - 2];
    [WizardButton appearance].backgroundColor    = wizardButtonColor;
}

@end
