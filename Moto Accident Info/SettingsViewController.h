//
//  SettingsViewController.h
//  Moto Accident Info
//
//  Created by Громов Андрей on 23.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *alertRadius;
@property (strong, nonatomic) IBOutlet UITextField *visibleRadius;
@property (strong, nonatomic) IBOutlet UISwitch *showAccidents;
@property (strong, nonatomic) IBOutlet UISwitch *showBreaks;
@property (strong, nonatomic) IBOutlet UISwitch *showSteals;
@property (strong, nonatomic) IBOutlet UISwitch *showOther;
@property (strong, nonatomic) IBOutlet UISwitch *showHeavy;
@property (strong, nonatomic) IBOutlet UITextField *maxAge;
@property (strong, nonatomic) IBOutlet UISwitch *finished;

@end
