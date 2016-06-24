//
//  Marker.h
//  
//
//  Created by Громов Андрей on 21.01.16.
//
//

#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>
#import "AccidentType.h"

@interface Marker : MKPointAnnotation
@property (assign, nonatomic) enum AccidentType type;
@property(strong, nonatomic) NSString * accId;
@end
