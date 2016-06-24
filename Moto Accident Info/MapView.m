//
//  MapView.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 28.01.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "MapView.h"
#import "Content.h"
#import "MarkerView.h"
#import "Accident.h"
#import "Marker.h"
#import "PermissionsControl.h"
#import "PhoneCall.h"

@interface MapView ()

@end

@implementation MapView
static MKCoordinateRegion currentRegionCenter;
static bool               isUpdated = NO;

- (void)viewDidLoad {
    if (_idAcc == Nil)_idAcc = @"";
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self decorate];

    _mapView.delegate          = self;
    _mapView.showsUserLocation = YES;
    if (isUpdated) {
        [_mapView setRegion:currentRegionCenter];
    }else{
        _mapView.userTrackingMode  = MKUserTrackingModeFollow;
    }
    [self renewMarkers];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self decorate];
    if ([_idAcc isEqualToString:@""])return;
    Accident *accident = [Content getById:_idAcc];
    _mapView.userTrackingMode = MKUserTrackingModeNone;
    MKCoordinateRegion region;
    region.center.latitude     = accident.location.coordinate.latitude;
    region.center.longitude    = accident.location.coordinate.longitude;
    region.span.latitudeDelta  = 0.02f;
    region.span.longitudeDelta = 0.02f;
    region = [_mapView regionThatFits:region];
    [_mapView setRegion:region animated:TRUE];
    currentRegionCenter = region;
    _idAcc              = @"";
    isUpdated           = YES;
}

- (void)decorate {
    [_createAccidentButton setEnabled:[PermissionsControl canCreateAccident]];
    [_callButton setEnabled:[PermissionsControl canCall]];
}


- (void)addMarkerForAccident:(Accident *)accident {
    Marker *marker = [[Marker alloc] init];
    marker.coordinate = CLLocationCoordinate2DMake(accident.location.coordinate.latitude, accident.location.coordinate.longitude);
    marker.title      = accident.text;
    marker.type       = accident.type;
    marker.accId      = [NSString stringWithFormat:@"%i", accident.idAcc];
    [_mapView addAnnotation:marker];
}

/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toDetails"]) {
        DetailsViewController *details = (id) segue.destinationViewController;
        details.idAcc = (NSString *) sender;
    }
}*/

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotation calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"toDetails" sender:[(MarkerView *) annotation accId]];
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)annotation {
    [self performSegueWithIdentifier:@"toDetails" sender:[(MarkerView *) annotation accId]];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    Marker     *marker = (Marker *) annotation;
    MarkerView *view   = [[MarkerView alloc] initWithAnnotation:annotation type:marker.type];
    //view.canShowCallout = YES;
    view.accId = marker.accId;
    return view;
}

- (void)renewMarkers {
    NSInteger      toRemoveCount = _mapView.annotations.count;
    NSMutableArray *toRemove     = [NSMutableArray arrayWithCapacity:(NSUInteger) toRemoveCount];
    for (id        annotation in _mapView.annotations)
        if (annotation != _mapView.userLocation)
            [toRemove addObject:annotation];
    [_mapView removeAnnotations:toRemove];
    NSArray       *accidents = [Content visibleAccidents];
    for (Accident *accident in accidents) {
        [self addMarkerForAccident:accident];
    }
}

- (void)mapView:(MKMapView *)mView regionDidChangeAnimated:(BOOL)animated {
    currentRegionCenter = [_mapView region];
    isUpdated           = YES;
}

- (IBAction)goToUserPressed:(id)sender {
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
}

- (IBAction)toList:(id)sender {
    [self performSegueWithIdentifier:@"mapToList" sender:nil];
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
@end
