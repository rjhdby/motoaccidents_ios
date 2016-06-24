//
//  PreAuthViewController.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 23.03.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import "PreAuthViewController.h"
#import "User.h"

@interface PreAuthViewController ()

@end

@implementation PreAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)toListOfAccidents {
    UIStoryboard     *createAccStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *initial             = [createAccStoryboard instantiateInitialViewController];
    [self presentViewController:initial animated:YES completion:nil];
}

- (void)toLoginScreen {
    UIStoryboard     *createAccStoryboard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
    UIViewController *initial             = [createAccStoryboard instantiateViewControllerWithIdentifier:@"Login"];
    [self presentViewController:initial animated:YES completion:nil];
    //[self performSegueWithIdentifier:@"toLoginScreen" sender:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _statusLabel.text = @"Авторизация...";
    if ([User isAuthorized] || [User isAnonymousForever]) {
        [self toListOfAccidents];
    } else {
        [self toLoginScreen];
    }
}

@end
