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
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self decorate];

    _mapView.delegate          = self;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode  = MKUserTrackingModeFollow;
    if (isUpdated) {
        [_mapView setRegion:currentRegionCenter];
    }
    [self renewMarkers];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self decorate];
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
    [_mapView addAnnotation:marker];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    Marker     *marker = (Marker *) annotation;
    MarkerView *view   = [[MarkerView alloc] initWithAnnotation:annotation type:marker.type];
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
    [self performSegueWithIdentifier:@"toCreateWizard" sender:nil];
}

- (IBAction)callButtonPressed:(id)sender {
    [PhoneCall call];
}
@end
