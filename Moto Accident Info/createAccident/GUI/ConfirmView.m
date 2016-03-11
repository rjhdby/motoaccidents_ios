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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (IBAction)confirmPressed:(id)sender {
    [NewAccidentContent setAddress:_address.text];
    [NewAccidentContent setText:_text.text];
    HTTPResponse *response = [[[HTTPRequest alloc] initWithRequest:[NewAccidentContent request]] execute];
    if ([response hasError])NSLog(@"%@, %@", response.error, response.errorDescription);
    else {
        [self performSegueWithIdentifier:@"toMain" sender:nil];
    }
}

@end
