//
//  OwnMessageCell.h
//  Moto Accident Info
//
//  Created by Громов Андрей on 31.01.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DecoratedCell.h"

@interface OwnMessageCell : UITableViewCell <DecoratedCell>
@property(strong, nonatomic) IBOutlet UILabel     *textLabel;
@property(strong, nonatomic) IBOutlet UILabel     *timeLabel;
@property(strong, nonatomic) IBOutlet UIImageView *innerView;
@property(nonatomic) NSString                     *msgId;

@end
