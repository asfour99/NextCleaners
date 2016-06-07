//
//  UIView+RoudedCorners.m
//  NextCleaners
//
//  Created by Monika on 03/06/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import "UIView+RoudedCorners.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (RoundedCorners)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    CGRect rect = self.bounds;
    
    // Create the path
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the view's layer
    self.layer.mask = maskLayer;
    
    
        CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
        borderLayer.frame = self.layer.bounds;
        borderLayer.path  = maskPath.CGPath;
        borderLayer.lineWidth   = 1.0f;
        borderLayer.strokeColor = [[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
        borderLayer.fillColor   = [UIColor clearColor].CGColor;
    
        [self.layer addSublayer:borderLayer];

}

@end
