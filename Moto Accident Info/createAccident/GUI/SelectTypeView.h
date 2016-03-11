//
//  SelectTypeView.h
//  Moto Accident Info
//
//  Created by Громов Андрей on 02.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTypeView : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *OtherButton;
@property (strong, nonatomic) IBOutlet UIButton *StealButton;
@property (strong, nonatomic) IBOutlet UIButton *BreakButton;
@property (strong, nonatomic) IBOutlet UIButton *AccidentButton;

- (void)setSelection;
@end
