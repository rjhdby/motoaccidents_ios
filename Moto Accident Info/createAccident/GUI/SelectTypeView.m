//
//  SelectTypeView.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 02.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import "SelectTypeView.h"
#import "NewAccidentContent.h"

@implementation SelectTypeView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSelection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (bool)isAccident {
    return [NewAccidentContent accidentType] == AT_MOTO_AUTO
           || [NewAccidentContent accidentType] == AT_MOTO_MOTO
           || [NewAccidentContent accidentType] == AT_MOTO_MAN
           || [NewAccidentContent accidentType] == AT_SOLO;
}

- (void)setSelection {
    [_AccidentButton setSelected:[self isAccident]];
    [_BreakButton setSelected:[NewAccidentContent accidentType] == AT_BREAK];
    [_OtherButton setSelected:[NewAccidentContent accidentType] == AT_OTHER];
    [_StealButton setSelected:[NewAccidentContent accidentType] == AT_STEAL];
}
- (IBAction)cancel:(id)sender {
    UIStoryboard     *createAccStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *initial             = [createAccStoryboard instantiateInitialViewController];
    [self presentViewController:initial animated:YES completion:nil];
}

- (IBAction)accidentSelected:(id)sender {
    if (_AccidentButton.selected)return;
    [NewAccidentContent setType:AT_MOTO_AUTO];
    [self setSelection];
}

- (IBAction)stealSelected:(id)sender {
    [NewAccidentContent setType:AT_STEAL];
    [self setSelection];
}

- (IBAction)breakSelected:(id)sender {
    if (_BreakButton.selected)return;
    [NewAccidentContent setType:AT_BREAK];
    [self setSelection];
}

- (IBAction)otherSelected:(id)sender {
    [NewAccidentContent setType:AT_OTHER];
    [self setSelection];
}

- (IBAction)next:(id)sender {
    if ([NewAccidentContent accidentType] == AT_BREAK) {
        [self performSegueWithIdentifier:@"toBreak" sender:nil];
    } else if ([NewAccidentContent accidentType] == AT_STEAL) {
        [self performSegueWithIdentifier:@"toConfirm" sender:nil];
    } else if ([NewAccidentContent accidentType] == AT_OTHER) {
        [self performSegueWithIdentifier:@"toConfirm" sender:nil];
    } else if ([self isAccident]) {
        [self performSegueWithIdentifier:@"toAccidentSubType" sender:nil];
    }
}
@end
