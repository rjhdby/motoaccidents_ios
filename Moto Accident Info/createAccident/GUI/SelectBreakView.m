//
//  SelectBreakView.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 02.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//
#import "SelectBreakView.h"
#import "NewAccidentContent.h"

@implementation SelectBreakView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDamageSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)setDamageSelected {
    [_toolsButton setSelected:[NewAccidentContent damage] == BS_TOOLS];
    [_gasButton setSelected:[NewAccidentContent damage] == BS_GASOLINE];
    [_accumButton setSelected:[NewAccidentContent damage] == BS_BATTERY];
    [_tireButton setSelected:[NewAccidentContent damage] == BS_TIRE];
    [_otherButton setSelected:[NewAccidentContent damage] == BS_OTHER];
}

- (IBAction)toolsSelected:(id)sender {
    [NewAccidentContent setDamage:BS_TOOLS];
    [self setDamageSelected];
}

- (IBAction)gasSelected:(id)sender {
    [NewAccidentContent setDamage:BS_GASOLINE];
    [self setDamageSelected];
}

- (IBAction)batterySelected:(id)sender {
    [NewAccidentContent setDamage:BS_BATTERY];
    [self setDamageSelected];
}

- (IBAction)tireSelected:(id)sender {
    [NewAccidentContent setDamage:BS_TIRE];
    [self setDamageSelected];
}

- (IBAction)otherSelected:(id)sender {
    [NewAccidentContent setDamage:BS_OTHER];
    [self setDamageSelected];
}

- (IBAction)next:(id)sender {
    [self performSegueWithIdentifier:@"toConfirm" sender:nil];
}
@end
