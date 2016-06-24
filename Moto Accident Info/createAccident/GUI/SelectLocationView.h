//
//  SelectLocationView.h
//  Moto Accident Info
//
//  Created by Громов Андрей on 02.02.16.
//  Copyright © 2016 motoAccident. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SelectLocationView : UIViewController <MKMapViewDelegate>
@property(strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;

@end
