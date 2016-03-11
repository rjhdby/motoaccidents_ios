//
//  MarkerView.h
//  
//
//  Created by Громов Андрей on 21.01.16.
//
//

#import <MapKit/MapKit.h>
#import "AccidentType.h"

@interface MarkerView : MKAnnotationView

- (instancetype)initWithAnnotation:(id <MKAnnotation>)annotation type:(enum AccidentType)type;

- (void)setImageForAccidentType:(enum AccidentType)type;
@end
