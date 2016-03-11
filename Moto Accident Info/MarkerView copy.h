//
//  MarkerView.h
//  
//
//  Created by Громов Андрей on 21.01.16.
//
//

#import <MapKit/MapKit.h>

@interface MarkerView : MKAnnotationView
- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation;
@end
