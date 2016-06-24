//
//  MapView.h
//  Moto Accident Info
//
//  Created by Громов Андрей on 28.01.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CoreViewController.h"

@interface MapView : CoreViewController<MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *toUserButton;
- (void)renewMarkers;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *createAccidentButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *callButton;
@property (strong, nonatomic) NSString *idAcc;

@end
