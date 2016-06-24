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
@property(strong, nonatomic) NSString * accId;

- (instancetype)initWithAnnotation:(id <MKAnnotation>)annotation type:(enum AccidentType)type;

- (void)setAccidentId:(NSString *)newAccId;

- (void)setImageForAccidentType:(enum AccidentType)type;
@end
