//
//  SelectAccidentSubtypeView.h
//  Moto Accident Info
//
//  Created by Громов Андрей on 02.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectAccidentSubtypeView : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *lethalDamageButton;
@property (strong, nonatomic) IBOutlet UIButton *heavyDamageButton;
@property (strong, nonatomic) IBOutlet UIButton *lightDamageButton;
@property (strong, nonatomic) IBOutlet UIButton *noneDamageButton;
@property (strong, nonatomic) IBOutlet UIButton *naDamageButton;
@property (strong, nonatomic) IBOutlet UIButton *motoManButton;
@property (strong, nonatomic) IBOutlet UIButton *soloButton;
@property (strong, nonatomic) IBOutlet UIButton *motoMotoButton;
@property (strong, nonatomic) IBOutlet UIButton *motoAutoButton;
@end
