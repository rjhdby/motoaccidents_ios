//
//  SettingsViewController.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 23.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import "SettingsViewController.h"
#import "UserSettings.h"
#import "User.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _alertRadius.text   = [NSString stringWithFormat:@"%i", UserSettings.alertRadius];
    _visibleRadius.text = [NSString stringWithFormat:@"%i", UserSettings.showRadius];
    _maxAge.text        = [NSString stringWithFormat:@"%i", UserSettings.maxAge];
    _showAccidents.on   = UserSettings.showAccidents;
    _showBreaks.on      = UserSettings.showBreaks;
    _showSteals.on      = UserSettings.showSteals;
    _showOther.on       = UserSettings.showOthers;
    _showHeavy.on       = UserSettings.showHeavy;
    _finished.on        = UserSettings.showFinished;
    _alertAccidents.on  = UserSettings.alertAccidents;
    _alertBreaks.on     = UserSettings.alertBreaks;
    _alertSteals.on     = UserSettings.alertSteals;
    _alertOther.on      = UserSettings.alertOthers;
    _alertHeavy.on      = UserSettings.alertHeavy;

    UIToolbar *numberToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items    = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc] initWithTitle:@"Готово" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    _alertRadius.inputAccessoryView   = numberToolbar;
    _visibleRadius.inputAccessoryView = numberToolbar;
    _maxAge.inputAccessoryView        = numberToolbar;
}

- (IBAction)toLoginScreen:(id)sender {
    UIStoryboard     *createAccStoryboard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
    UIViewController *initial             = [createAccStoryboard instantiateInitialViewController];
    [self presentViewController:initial animated:YES completion:nil];
}

- (void)doneWithNumberPad {
    [_alertRadius resignFirstResponder];
    [_visibleRadius resignFirstResponder];
    [_maxAge resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UserSettings showHeavy:_showHeavy.isOn];
    [UserSettings showOthers:_showOther.isOn];
    [UserSettings showSteals:_showSteals.isOn];
    [UserSettings showBreaks:_showBreaks.isOn];
    [UserSettings showAccidents:_showAccidents.isOn];
    [UserSettings showFinished:_finished.isOn];

    [UserSettings alertAccidents:_alertAccidents.isOn];
    [UserSettings alertBreaks:_alertBreaks.isOn];
    [UserSettings alertSteals:_alertSteals.isOn];
    [UserSettings alertOthers:_alertOther.isOn];
    [UserSettings alertHeavy:_alertHeavy.isOn];

    [UserSettings showRadius:_visibleRadius.text.intValue];
    [UserSettings alertRadius:MIN(_alertRadius.text.intValue, _visibleRadius.text.intValue)];
    [UserSettings maxAge:_maxAge.text.intValue];
}

- (IBAction)signOut:(id)sender {
    [User signOut];
    UIStoryboard     *createAccStoryboard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
    UIViewController *initial             = [createAccStoryboard instantiateViewControllerWithIdentifier:@"Login"];
    [self presentViewController:initial animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)visibleTrigger:(UISwitch *)sender {
    if ([sender isEqual:_showAccidents]) {
        _alertAccidents.on = _showAccidents.isOn;
    } else if ([sender isEqual:_showBreaks]) {
        _alertBreaks.on = _showBreaks.isOn;
    } else if ([sender isEqual:_showSteals]) {
        _alertSteals.on = _showSteals.isOn;
    } else if ([sender isEqual:_showOther]) {
        _alertOther.on = _showOther.isOn;
    } else if ([sender isEqual:_showHeavy]) {
        _alertHeavy.on = _showHeavy.isOn;
    }
}

@end
