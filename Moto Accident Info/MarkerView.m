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
- (instancetype)initWithAnnotation:(id <MKAnnotation>)annotation type:(enum AccidentType)type {
    // The re-use identifier is always nil because these custom pins may be visually different from one another
    self = [super initWithAnnotation:annotation reuseIdentifier:nil];
    [self setImageForAccidentType:type];
    return self;
}

- (void)setImageForAccidentType:(enum AccidentType)type {
    NSString *imageName;
    switch (type) {
        case AT_MOTO_MOTO:
        case AT_MOTO_AUTO:
        case AT_MOTO_MAN:
        case AT_SOLO:
            imageName = @"map_accident";
            break;
        case AT_BREAK:
            imageName = @"map_break";
            break;
        case AT_STEAL:
            imageName = @"map_steal";
            break;
        case AT_OTHER:
        default:
            imageName = @"map_other";
    }
    self.image        = [UIImage imageNamed:imageName];
    self.centerOffset = CGPointMake(0, -27);
}
@end
