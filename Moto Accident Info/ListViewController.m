//
//  ListViewController.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 25.01.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import "ListViewController.h"
#import "Content.h"
#import "Accident.h"
#import "AccidentCell.h"
#import "DetailsViewController.h"
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
    [self redraw];
    [Content update];
    [self subscribeForLocationUpdate];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateData];
    [self redraw];

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"listToDetails"]) {
        DetailsViewController *details = (id) segue.destinationViewController;
        details.idAcc = (NSString *) sender;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AccidentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"listToDetails" sender:cell.accId];
}

- (IBAction)listToMap:(id)sender {
    [self performSegueWithIdentifier:@"listToMap" sender:nil];
    [self.navigationController removeFromParentViewController];
}

- (IBAction)createAccidentPressed:(id)sender {
    [self performSegueWithIdentifier:@"toCreateWizard" sender:nil];
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

@end
