//
//  RegistrationViewController.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 19.03.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSString * urlString = @"http://forum.moto.msk.ru/index.php?app=core&module=global&section=register&agree_tos=1";
    NSString * urlString = @"http://forum.moto.msk.ru/index.php?app=core&module=global&section=register";
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
