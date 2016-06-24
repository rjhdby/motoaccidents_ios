//
//  ListViewController.h
//  Moto Accident Info
//
//  Created by Громов Андрей on 25.01.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainView.h"
#import "LocationUpdateSubscriber.h"
#import "CoreViewController.h"

@interface ListViewController : CoreViewController <UITableViewDataSource, UITableViewDelegate, LocationUpdateSubscriber>
@property(strong, nonatomic) IBOutlet UITableView     *ListOfAccidentsTable;
@property(strong, nonatomic) IBOutlet UIBarButtonItem *createAccidentButton;
@property(strong, nonatomic) IBOutlet UIBarButtonItem *callButton;
@property (strong, nonatomic) IBOutlet UITableView *listView;

@end
