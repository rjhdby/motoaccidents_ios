//
//  SettingsViewController.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 23.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import "SettingsViewController.h"
#import "UserSettings.h"
#import "Content.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _alertRadius.text   = [NSString stringWithFormat:@"%i", [UserSettings alertRadius]];
    _visibleRadius.text = [NSString stringWithFormat:@"%i", [UserSettings showRadius]];
    _maxAge.text        = [NSString stringWithFormat:@"%i", [UserSettings maxAge]];
    _showAccidents.on   = [UserSettings showAccidents];
    _showBreaks.on      = [UserSettings showBreaks];
    _showSteals.on      = [UserSettings showSteals];
    _showOther.on       = [UserSettings showOthers];
    _showHeavy.on       = [UserSettings showHeavy];
    _finished.on        = [UserSettings showFinished];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UserSettings showHeavy:_showHeavy.isOn];
    [UserSettings showOthers:_showOther.isOn];
    [UserSettings showSteals:_showSteals.isOn];
    [UserSettings showBreaks:_showBreaks.isOn];
    [UserSettings showAccidents:_showAccidents.isOn];
    [UserSettings showFinished:_finished.isOn];

    [UserSettings showRadius:_visibleRadius.text.intValue];
    [UserSettings alertRadius:_alertRadius.text.intValue];
    [UserSettings maxAge:_maxAge.text.intValue];
    [Content update];
}


@end
