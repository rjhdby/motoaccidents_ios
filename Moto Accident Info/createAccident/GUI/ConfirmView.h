//
//  ConfirmView.h
//  Moto Accident Info
//
//  Created by Громов Андрей on 02.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmView : UIViewController <UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *address;
@property (strong, nonatomic) IBOutlet UITextView *text;
@property (strong, nonatomic) IBOutlet UISwitch *statSwitch;
@property (strong, nonatomic) IBOutlet UIButton *closeKeyboard;

@end
