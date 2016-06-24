//
//  SelectLocationView.m
//  Moto Accident Info
//
//  Created by Громов Андрей on 02.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "SelectLocationView.h"
#import "NewAccidentContent.h"
#import "Content.h"
#import "MarkerView.h"
#import "Marker.h"
#import "Accident.h"
#import "LocationManager.h"

@implementation SelectLocationView

- (void)viewDidLoad {
    [super viewDidLoad];
    [NewAccidentContent cleanUp];
    [self renewMarkers];
    [self goToUser];
}

- (void)goToUser {
    MKCoordinateRegion region;
    MKCoordinateSpan   span;
    CLLocation         *location = [[LocationManager instance] current];
    span.latitudeDelta         = 0.005;
    span.longitudeDelta        = 0.005;
    region.span                = span;
    region.center              = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    _mapView.showsUserLocation = YES;
    [_mapView setRegion:region animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [NewAccidentContent setLocation:[[CLLocation alloc] initWithLatitude:_mapView.centerCoordinate.latitude longitude:_mapView.centerCoordinate.longitude]];
}

- (IBAction)cancel:(id)sender {
    UIStoryboard     *createAccStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *initial             = [createAccStoryboard instantiateInitialViewController];
    [self presentViewController:initial animated:YES completion:nil];
}

- (IBAction)nextButtonPressed:(id)sender {
    [self addWaiterScreen];
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:[NewAccidentContent location] completionHandler:^(NSArray *placeMarks, NSError *error) {
        NSString *address;
        if (error || [placeMarks count] == 0) {
            address = @"Не удалось определить";
        } else {
            CLPlacemark *placeMark = placeMarks[0];
            address = [NSString stringWithFormat:@"%@, %@", placeMark.locality, placeMark.name];
        }
        [NewAccidentContent setAddress:address];
        [self removeWaiterScreen];
        [self performSegueWithIdentifier:@"toTypeSelect" sender:nil];
    }];
}

- (IBAction)toUserPressed:(id)sender {
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
}

- (void)addWaiterScreen {
    [_nextButton setEnabled:NO];
    _nextButton.titleLabel.text = @"Ищем адрес";
}

- (void)removeWaiterScreen {
    [_nextButton setEnabled:YES];
    _nextButton.titleLabel.text = @"Далее";
}
@end
