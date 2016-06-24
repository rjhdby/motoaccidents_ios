//
//  SettingsViewController.h
//  Moto Accident Info
//
//  Created by Громов Андрей on 23.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreViewController.h"

@interface SettingsViewController : CoreViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *alertRadius;
@property (strong, nonatomic) IBOutlet UITextField *visibleRadius;
@property (strong, nonatomic) IBOutlet UISwitch *showAccidents;
@property (strong, nonatomic) IBOutlet UISwitch *showBreaks;
@property (strong, nonatomic) IBOutlet UISwitch *showSteals;
@property (strong, nonatomic) IBOutlet UISwitch *showOther;
@property (strong, nonatomic) IBOutlet UISwitch *showHeavy;
@property (strong, nonatomic) IBOutlet UITextField *maxAge;
@property (strong, nonatomic) IBOutlet UISwitch *finished;
@property (strong, nonatomic) IBOutlet UIButton *signOut;
@property (strong, nonatomic) IBOutlet UISwitch *alertAccidents;
@property (strong, nonatomic) IBOutlet UISwitch *alertBreaks;
@property (strong, nonatomic) IBOutlet UISwitch *alertSteals;
@property (strong, nonatomic) IBOutlet UISwitch *alertOther;
@property (strong, nonatomic) IBOutlet UISwitch *alertHeavy;

@end
