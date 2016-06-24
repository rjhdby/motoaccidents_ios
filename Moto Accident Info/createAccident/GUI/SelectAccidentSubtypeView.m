//
//  SelectAccidentSubtypeView.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 02.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import "SelectAccidentSubtypeView.h"
#import "NewAccidentContent.h"

@implementation SelectAccidentSubtypeView
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTypeSelection];
    [self setDamageSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)setTypeSelection {
    [_motoAutoButton setSelected:[NewAccidentContent accidentType] == AT_MOTO_AUTO];
    [_motoMotoButton setSelected:[NewAccidentContent accidentType] == AT_MOTO_MOTO];
    [_soloButton setSelected:[NewAccidentContent accidentType] == AT_SOLO];
    [_motoManButton setSelected:[NewAccidentContent accidentType] == AT_MOTO_MAN];

}
- (IBAction)cancel:(id)sender {
    UIStoryboard     *createAccStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *initial             = [createAccStoryboard instantiateInitialViewController];
    [self presentViewController:initial animated:YES completion:nil];
}

- (void)setDamageSelected {
    [_naDamageButton setSelected:[NewAccidentContent damage] == MS_UNKNOWN];
    [_noneDamageButton setSelected:[NewAccidentContent damage] == MS_NONE];
    [_lightDamageButton setSelected:[NewAccidentContent damage] == MS_LIGHT];
    [_heavyDamageButton setSelected:[NewAccidentContent damage] == MS_HEAVY];
    [_lethalDamageButton setSelected:[NewAccidentContent damage] == MS_LETHAL];
}

- (IBAction)motoAutoSelected:(id)sender {
    [NewAccidentContent setType:AT_MOTO_AUTO];
    [self setTypeSelection];
}

- (IBAction)motoMotoSelected:(id)sender {
    [NewAccidentContent setType:AT_MOTO_MOTO];
    [self setTypeSelection];
}

- (IBAction)soloSelected:(id)sender {
    [NewAccidentContent setType:AT_SOLO];
    [self setTypeSelection];
}

- (IBAction)motoManSelected:(id)sender {
    [NewAccidentContent setType:AT_MOTO_MAN];
    [self setTypeSelection];
}

- (IBAction)next:(id)sender {
    [self performSegueWithIdentifier:@"toConfirm" sender:nil];
}

- (IBAction)naDamageSelected:(id)sender {
    [NewAccidentContent setDamage:MS_UNKNOWN];
    [self setDamageSelected];
}

- (IBAction)lightDamageSelected:(id)sender {
    [NewAccidentContent setDamage:MS_LIGHT];
    [self setDamageSelected];
}

- (IBAction)noneDamageSelected:(id)sender {
    [NewAccidentContent setDamage:MS_NONE];
    [self setDamageSelected];
}

- (IBAction)heavyDamageSelected:(id)sender {
    [NewAccidentContent setDamage:MS_HEAVY];
    [self setDamageSelected];
}

- (IBAction)lethalDamageSelected:(id)sender {
    [NewAccidentContent setDamage:MS_LETHAL];
    [self setDamageSelected];
}

@end
