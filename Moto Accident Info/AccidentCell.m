//
//  AccidentCell.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 25.01.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import "AccidentCell.h"
#import "Accident.h"
#import "Content.h"

@implementation AccidentCell
- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)decorateWith:(Accident *)accident {
    _address.text       = accident.address;
    _age.text           = accident.getAge;
    _distance.text      = accident.getDistanceFromUser;
    _accidentType.text  = [AccidentType string:accident.type];
    _damage.text        = [DamageStatus stringForStatus:accident.damage];
    _labelText.text     = accident.text;
    _messagesCount.text = [NSString stringWithFormat:@"%lu", (unsigned long)[accident.messages count]];
    if ([Content hasUndeadForAccident:accident]) {
        _messagesCount.textColor = [UIColor redColor];
    } else {
        _messagesCount.textColor = [UIColor grayColor];
    }
    _accId = [NSString stringWithFormat:@"%i", accident.idAcc];
}

- (NSString *)getId {
    return _accId;
}


@end
