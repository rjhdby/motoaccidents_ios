//
//  AuthViewController.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 28.01.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import "AuthViewController.h"
#import "User.h"
#import "UserSettings.h"

@interface AuthViewController ()

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_loginButton addTarget:self action:@selector(auth) forControlEvents:UIControlEventTouchUpInside];
    [_skipButton addTarget:self action:@selector(avoidLogin) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([User isAuthorized]) {
        [self toListOfAccidents];
    } else {
        _loginField.text    = [UserSettings login];
        _passwordField.text = [UserSettings password];
    }
}

- (void)auth {
    [User authWithLogin:_loginField.text password:_passwordField.text];
    if ([User isAuthorized]) {
        [self toListOfAccidents];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ошибка авторизации" message:@"Пользователь с такими логином и паролем не найден" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleDefault handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Войти анонимно" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self avoidLogin];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)avoidLogin {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Войти без регистрации?" message:@"Функционал создания событий и сообщений будет недоступен." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleDefault handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Войти" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [User setAnonymous];
        [self toListOfAccidents];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Всегда входить без регистрации" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [User setAnonymousForever];
        [self toListOfAccidents];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)toListOfAccidents {
    [self performSegueWithIdentifier:@"leaveLogin" sender:nil];
}
@end
