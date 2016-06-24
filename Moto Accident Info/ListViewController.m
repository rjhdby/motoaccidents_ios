//
//  ListViewController.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 25.01.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "ListViewController.h"
#import "Content.h"
#import "Accident.h"
#import "AccidentCell.h"
#import "PermissionsControl.h"
#import "PhoneCall.h"
#import "LocationManager.h"

@interface ListViewController ()

@end

@implementation ListViewController
static NSArray *visibleAccidents;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [_callButton setEnabled:[PermissionsControl canCall]];
    [self subscribeForLocationUpdate];
}

- (void)updateContent {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.hidesWhenStopped = YES;
    [_listView addSubview:spinner];
    spinner.center = [_listView center];
    [spinner startAnimating];
    dispatch_queue_t downloadQueue = dispatch_queue_create("downloader", NULL);
    dispatch_async(downloadQueue, ^{
        [Content update];
        dispatch_async(dispatch_get_main_queue(), ^{
            [spinner stopAnimating];
            [self updateData];
            [self redraw];
        });
    });
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self redraw];
    [self updateContent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self revokeLocationUpdateSubscribe];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [visibleAccidents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Accident                        *accident       = visibleAccidents[(NSUInteger) indexPath.row];
    NSString                        *CellIdentifier = accident.status == AS_ENDED ? @"endedAccidentCell" : @"accidentCell";
    UITableViewCell <DecoratedCell> *cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell decorateWith:accident];
    return cell;
}

/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toMapSegue"]) {
        DetailsViewController *details = (id) segue.destinationViewController;
        details.idAcc = (NSString *) sender;
    }
}*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AccidentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"toDetails" sender:cell.accId];
}

- (IBAction)listToMap:(id)sender {
    [self performSegueWithIdentifier:@"listToMap" sender:nil];
    [self.navigationController removeFromParentViewController];
}

- (IBAction)createAccidentPressed:(id)sender {
    //[self performSegueWithIdentifier:@"toCreateWizard" sender:nil];
    UIStoryboard     *createAccStoryboard = [UIStoryboard storyboardWithName:@"CreateAcc" bundle:nil];
    UIViewController *initial             = [createAccStoryboard instantiateInitialViewController];
    [self presentViewController:initial animated:YES completion:nil];
}

- (IBAction)callButtonPressed:(id)sender {
    [PhoneCall call];
}

- (void)redraw {
    [_createAccidentButton setEnabled:[PermissionsControl canCreateAccident]];
    [_ListOfAccidentsTable reloadData];
}

- (void)updateData {
    visibleAccidents = [Content visibleAccidents];
}

- (void)onLocationUpdate:(CLLocation *)newLocation {
    [self updateData];
    [self redraw];
}

- (void)subscribeForLocationUpdate {
    [LocationManager subscribe:self name:NSStringFromClass([self class])];
}

- (void)revokeLocationUpdateSubscribe {
    [LocationManager revokeSubscription:NSStringFromClass([self class])];
}

- (IBAction)longTapRecognizer:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint     p          = [sender locationInView:_listView];
        NSIndexPath *indexPath = [_listView indexPathForRowAtPoint:p];
        if (indexPath == nil) return;
        UITableViewCell <DecoratedCell> *cell       = [_listView cellForRowAtIndexPath:indexPath];
        UIPasteboard                    *pasteboard = [UIPasteboard generalPasteboard];
        Accident                        *ac         = [Content getById:[cell getId]];
        pasteboard.string = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@, https://yandex.ru/maps/?ll=%f%%2C%f&z=15&whatshere%%5Bpoint%%5D=%f%%2C%f&whatshere%%5Bzoom%%5D=15",
                                                       ac.getTime,
                                                        ac.owner,
                                                       ac.address,
                                                       [AccidentType string:ac.type],
                                                       [DamageStatus stringForStatus:ac.damage],
                                                       ac.text,
                                                       ac.location.coordinate.longitude,
                                                       ac.location.coordinate.latitude,
                                                       ac.location.coordinate.longitude,
                                                       ac.location.coordinate.latitude];
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