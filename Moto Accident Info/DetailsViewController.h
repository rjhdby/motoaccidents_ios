//
//  DetailsViewController.h
//  Moto Accident Info
//
//  Created by Громов Андрей on 28.01.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationUpdateSubscriber.h"

@class MessageCell;
@class OwnMessageCell;

@interface DetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, LocationUpdateSubscriber, UITextFieldDelegate, UIAlertViewDelegate>
@property(strong, nonatomic) IBOutlet UILabel            *ageLabel;
@property(strong, nonatomic) IBOutlet UILabel            *distanceLabel;
@property(strong, nonatomic) IBOutlet UILabel            *addressLabel;
@property(strong, nonatomic) IBOutlet UILabel            *descriptionLabel;
@property(strong, nonatomic) IBOutlet UITableView        *tableView;
@property(strong, nonatomic) IBOutlet UIButton           *sendMessageButton;
@property(strong, nonatomic) IBOutlet UITextField        *messageField;
@property(strong, nonatomic) IBOutlet UILabel            *typeLabel;
@property(strong, nonatomic) IBOutlet UILabel            *damageLabel;
@property(strong, nonatomic) IBOutlet UILabel            *ownerLabel;
@property(strong, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property(strong, nonatomic) NSString                 *idAcc;
@property(strong, nonatomic) IBOutlet UIBarButtonItem *toMapButton;

- (void)updateData;

- (IBAction)toMap:(id)sender;
@end
