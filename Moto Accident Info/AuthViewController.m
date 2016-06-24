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
UIAlertView *userNotFountAlertView;
UIAlertView *enterWithoutLogin;
UIAlertView *registrationAlertView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];

    [_loginField setDelegate:self];
    [_passwordField setDelegate:self];
    [_loginButton addTarget:self action:@selector(auth) forControlEvents:UIControlEventTouchUpInside];
    [_skipButton addTarget:self action:@selector(avoidLogin) forControlEvents:UIControlEventTouchUpInside];
    [_registrationButton addTarget:self action:@selector(registration) forControlEvents:UIControlEventTouchUpInside];

    UIToolbar *numberToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items    = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc] initWithTitle:@"Готово" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    _loginField.inputAccessoryView    = numberToolbar;
    _passwordField.inputAccessoryView = numberToolbar;

    registrationAlertView = [[UIAlertView alloc]initWithTitle:@"Регистрация"
                                                      message:@"Вы будете перенаправлены на форму регистрации форума forum.moto.msk.ru. Для регистрации потребуется указать номер телефона и ввести присланный по СМС код"
                                                     delegate:self
                                            cancelButtonTitle:@"Отмена"
                                            otherButtonTitles:@"ОК", nil];
    
    userNotFountAlertView = [[UIAlertView alloc] initWithTitle:@"Ошибка авторизации"
                                                       message:@"Пользователь с такими логином и паролем не найден"
                                                      delegate:self
                                             cancelButtonTitle:@"Отмена"
                                             otherButtonTitles:@"Войти анонимно", nil];
    enterWithoutLogin     = [[UIAlertView alloc] initWithTitle:@"Войти без регистрации?"
                                                       message:@"Функционал создания событий и сообщений будет недоступен."
                                                      delegate:self
                                             cancelButtonTitle:@"Отмена"
                                             otherButtonTitles:@"Войти", @"Войти и запомнить", nil];
}

-(void)registration{
    [registrationAlertView show];
}
- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[notification userInfo][UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    _bottomConstraint.constant = keyboardSize.height / 2;
}

- (void)keyboardWillHide {
    _bottomConstraint.constant = 0;
}

- (void)doneWithNumberPad {
    [_loginField resignFirstResponder];
    [_passwordField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([User isAuthorized] || [User isAnonymousForever]) {
        [self toListOfAccidents];
    } else {
        _loginField.text    = UserSettings.login;
        _passwordField.text = UserSettings.password;
    }
}

- (void)auth {
    [User authWithLogin:_loginField.text password:_passwordField.text];
    if ([User isAuthorized]) {
        [self toListOfAccidents];
    } else {

        [userNotFountAlertView show];
    }
}

- (void)avoidLogin {
    [enterWithoutLogin show];
}

- (void)toListOfAccidents {
    UIStoryboard     *createAccStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *initial             = [createAccStoryboard instantiateInitialViewController];
    [self presentViewController:initial animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([theAlert isEqual:userNotFountAlertView]) {
        [userNotFountAlertView setHidden:YES];
        switch (buttonIndex) {
            case 0:
                break;
            case 1:
                [self avoidLogin];
                break;
            default:
                break;
        }
    }
    if ([theAlert isEqual:enterWithoutLogin]) {
        [enterWithoutLogin setHidden:YES];
        switch (buttonIndex) {
            case 0:
                break;
            case 1:
                [User setAnonymous];
                [self toListOfAccidents];
                break;
            case 2:
                [User setAnonymousForever];
                [self toListOfAccidents];
                break;
            default:
                break;
        }
    }
    if([theAlert isEqual:registrationAlertView]){
        switch (buttonIndex){
            case 0:
                break;
            case 1:
                [self performSegueWithIdentifier:@"toRegistration" sender:nil];
            default:
                break;
        }
    }
}
@end
