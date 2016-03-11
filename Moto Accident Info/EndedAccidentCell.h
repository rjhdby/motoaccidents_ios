//
//  AccidentCell.h
//  Moto Accident Info
//
//  Created by Громов Андрей on 25.01.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DecoratedCell.h"

@class Accident;

@interface EndedAccidentCell : UITableViewCell <DecoratedCell>
@property(strong, nonatomic) IBOutlet UILabel *address;
@property(strong, nonatomic) IBOutlet UILabel *age;
@property(strong, nonatomic) IBOutlet UILabel *distance;
@property(strong, nonatomic) NSString         *accId;
@property(strong, nonatomic) IBOutlet UILabel *accidentType;
@property(strong, nonatomic) IBOutlet UILabel *labelText;


@property (strong, nonatomic) IBOutlet UILabel *damage;

@property (strong, nonatomic) IBOutlet UILabel *messagesCount;
- (void)decorateWith:(Accident *)accident;
@end
