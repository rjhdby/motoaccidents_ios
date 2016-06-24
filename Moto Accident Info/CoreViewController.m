//
//  CoreViewController.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 09.04.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import "CoreViewController.h"
#import "Content.h"
#import "DetailsViewController.h"

@interface CoreViewController ()

@end

@implementation CoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground) name:UIApplicationDidBecomeActiveNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toDetails {
    if ([Content toDetails] == 0)return;
    [self performSegueWithIdentifier:@"toDetails" sender:[NSString stringWithFormat:@"%i", [Content toDetails]]];
}

- (void)appWillEnterForeground {
    [self toDetails];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toDetails"]) {
        [Content toDetails:0];
        DetailsViewController *details = (id) segue.destinationViewController;
        details.idAcc = (NSString *) sender;
    }
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
