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
#import "AccidentTools.h"
#import "DefaultDecorator.h"
#import "MapView.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController
Accident    *accident;
NSArray     *messages;
UITextView  *textView;
UIAlertView *errorSendAlertView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];

    _tableView.rowHeight          = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 56;
    [_messageField setDelegate:self];
    accident = [Content getById:_idAcc];
    [Content setLastReadForAccidentId:accident.idAcc];
    [self updateData];
    [self decorate];
    errorSendAlertView = [[UIAlertView alloc] initWithTitle:@"Ошибка"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Отмена"
                                          otherButtonTitles:@"Повторить отправку", nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[notification userInfo][UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    _bottomConstraint.constant = keyboardSize.height;
}

- (void)keyboardWillHide {
    _bottomConstraint.constant = 0;
}

- (void)appWillEnterActive {
    if ([Content toDetails] == 0)
        return;
    _idAcc = [NSString stringWithFormat:@"%i", [Content toDetails]];
    [Content toDetails:0];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message  *message = messages[(NSUInteger) indexPath.row];
    NSString *identifier;
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
    [_messageField resignFirstResponder];
    [self sendMessage];
}

- (void)sendMessage {
    PreparedRequest *request = [[PreparedRequest alloc] initWithMethod:R_NEW_MESSAGE];
    [request authRequired];
    [request add:@"id" value:_idAcc];
    [request add:@"t" value:_messageField.text];
    HTTPResponse *response = [[[HTTPRequest alloc] initWithRequest:request] execute];
    if ([response hasError]) {
        [errorSendAlertView setMessage:[response error]];
        [errorSendAlertView show];
    } else {
        [Content update];
        [self updateData];
        _messageField.text = @"";
        [self decorate];
        [Content setLastReadForAccidentId:accident.idAcc];
    }
}

- (void)onLocationUpdate:(CLLocation *)newLocation {
    [self decorateStatic];
}

- (void)subscribeForLocationUpdate {
    [LocationManager subscribe:self name:NSStringFromClass([self class])];
}

- (void)revokeLocationUpdateSubscribe {
    [LocationManager revokeSubscription:NSStringFromClass([self class])];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float   margin = 8.0f;
    CGFloat width  = [DefaultDecorator screenWidth] - 3 * margin - 32;

    Message  *message  = messages[(NSUInteger) indexPath.row];
    NSString *owner    = message.owner;
    NSString *text     = [NSString stringWithFormat:@"%@ %@", message.text, [AccidentTools formattedAge:message.time]];
    CGSize   rect      = CGSizeMake(width, CGFLOAT_MAX);
    CGRect   textRect  = [text boundingRectWithSize:rect
                                            options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                         attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}
                                            context:nil];
    CGRect   ownerRect = [owner boundingRectWithSize:rect
                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                          attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f]}
                                             context:nil];

    return ceilf(textRect.size.height + ownerRect.size.height + 2 * margin);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toMapSegue"]) {
        MapView *map = (id) segue.destinationViewController;
        map.idAcc = (NSString *) sender;
    }
}

- (IBAction)toMap:(id)sender {
    [self performSegueWithIdentifier:@"toMapSegue" sender:_idAcc];
    [self.navigationController removeFromParentViewController];
}

- (void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex {
    [errorSendAlertView setHidden:YES];
    if (buttonIndex == 1)[self sendMessage];
}

- (IBAction)longTap:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint     p          = [sender locationInView:_tableView];
        NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:p];
        if (indexPath == nil) return;
        UITableViewCell <DecoratedCell> *cell       = [_tableView cellForRowAtIndexPath:indexPath];
        UIPasteboard                    *pasteboard = [UIPasteboard generalPasteboard];
        Message                         *message    = [accident getMessageById:[cell getId]];
        pasteboard.string = [NSString stringWithFormat:@"%@, %@",
                                                       message.owner,
                                                       message.text];
        [self copyAlert];
    }
}

- (void)copyAlert {
    NSString *message = @"Скопировано";
    int      duration = 2;
    if (NSClassFromString(@"UIAlertController")) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
    } else {
        UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
        [toast show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [toast dismissWithClickedButtonIndex:0 animated:YES];
        });
    }
}
@end
