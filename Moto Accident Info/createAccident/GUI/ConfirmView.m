//
//  ConfirmView.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 02.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import "ConfirmView.h"
#import "HTTPRequest.h"
#import "NewAccidentContent.h"
#import "HTTPResponse.h"

@implementation ConfirmView
- (void)viewDidLoad {
    [super viewDidLoad];
    _address.text = [NewAccidentContent address];
    [_address setDelegate:self];
    [_text setDelegate:self];

    UIToolbar *numberToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items    = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc] initWithTitle:@"Готово" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    _address.inputAccessoryView   = numberToolbar;
    _text.inputAccessoryView = numberToolbar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (IBAction)cancel:(id)sender {
    UIStoryboard     *createAccStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *initial             = [createAccStoryboard instantiateInitialViewController];
    [self presentViewController:initial animated:YES completion:nil];
}

- (IBAction)confirmPressed:(id)sender {
    [NewAccidentContent setAddress:_address.text];
    [NewAccidentContent setText:_text.text];
    HTTPResponse *response = [[[HTTPRequest alloc] initWithRequest:[NewAccidentContent request]] execute];
    if ([response hasError])NSLog(@"%@, %@", response.error, response.errorDescription);
    else {
        //[self performSegueWithIdentifier:@"toMain" sender:nil];
        UIStoryboard     *createAccStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *initial             = [createAccStoryboard instantiateInitialViewController];
        [self presentViewController:initial animated:YES completion:nil];
    }
}
- (void)doneWithNumberPad {
    [_address resignFirstResponder];
    [_text resignFirstResponder];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
    return YES;
}
@end
