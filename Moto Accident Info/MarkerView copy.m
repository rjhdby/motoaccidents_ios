//
//  MarkerView.m
//  
//
//  Created by Громов Андрей on 21.01.16.
//
//

#import "MarkerView.h"

@implementation MarkerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithAnnotation:(id <MKAnnotation>)annotation {
    // The re-use identifier is always nil because these custom pins may be visually different from one another
    self = [super initWithAnnotation:annotation reuseIdentifier:nil];


    UIImage *image =[UIImage imageNamed:@"accident.9.png"];
    self.image =image;
    return self;
}
@end
