//
//  DetailsViewController.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 28.01.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import "DetailsViewController.h"
#import "Accident.h"
#import "Content.h"
#import "Message.h"
#import "User.h"
#import "OwnMessageCell.h"
#import "PermissionsControl.h"
#import "PreparedRequest.h"
#import "HTTPResponse.h"
#import "HTTPRequest.h"
#import "LocationManager.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController
Accident *accident;
NSArray  *messages;

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.rowHeight          = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 56;
    accident = [Content getById:_idAcc];
    [Content setLastReadForAccidentId:accident.idAcc];
    [self updateData];
    [self decorate];

}

- (void)decorate {
    [self decorateStatic];
    [self decorateMessages];
}

- (void)decorateStatic {
    _addressLabel.text     = [accident address];
    _ageLabel.text         = [accident getAge];
    _distanceLabel.text    = [accident getDistanceFromUser];
    _descriptionLabel.text = [accident text];
    _typeLabel.text        = [AccidentType string:[accident type]];
    _damageLabel.text      = [DamageStatus stringForStatus:[accident damage]];
    _ownerLabel.text       = [accident owner];
}

- (void)decorateMessages {
    [_sendMessageButton setEnabled:[PermissionsControl canWriteComment]];
    [_tableView reloadData];
}

- (void)updateData {
    messages = [Content messagesFromAccident:@(accident.idAcc)];
    [_tableView reloadData];
    if ([messages count] == 0)return;
    NSIndexPath *ipath = [NSIndexPath indexPathForRow:[messages count] - 1 inSection:0];
    [_tableView scrollToRowAtIndexPath:ipath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateData];
    [self decorate];
    [self subscribeForLocationUpdate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self revokeLocationUpdateSubscribe];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message  *message = messages[(NSUInteger) indexPath.row];
    NSString *identifier;
    //= [message ownerId] == [User userId] ? @"ownMessage" : @"message";
    if ([message ownerId] == [User userId]) {
        identifier = @"ownMessage";
    } else if (indexPath.row != 0 && [messages[(NSUInteger) indexPath.row - 1] ownerId] == [message ownerId]) {
        identifier = @"messageCellWithoutOwner";
    } else {
        identifier = @"message";
    }
    UITableViewCell <DecoratedCell> *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell decorateWith:message];
    return cell;
}

- (IBAction)newMessagePressed:(id)sender {
    if ([_messageField.text length] < 2)return;
    [self sendMessage];
}

- (void)sendMessage {
    PreparedRequest *request = [[PreparedRequest alloc] initWithMethod:R_NEW_MESSAGE];
    [request authRequired];
    [request add:@"id" value:_idAcc];
    [request add:@"t" value:_messageField.text];
    HTTPResponse *response = [[[HTTPRequest alloc] initWithRequest:request] execute];
    if ([response hasError]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ошибка" message:[response error] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleDefault handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Повторить отправку" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self sendMessage];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [Content update];
        [self updateData];
        _messageField.text = @"";
        [self decorate];
        [Content setLastReadForAccidentId:accident.idAcc];
    }
}

- (void)onLocationUpdate:(CLLocation *)newLocation {
    //[self updateData];
    [self decorateStatic];
}

- (void)subscribeForLocationUpdate {
    [LocationManager subscribe:self name:NSStringFromClass([self class])];
}

- (void)revokeLocationUpdateSubscribe {
    [LocationManager revokeSubscription:NSStringFromClass([self class])];
}
@end
