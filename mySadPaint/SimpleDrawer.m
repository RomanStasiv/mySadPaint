//
//  SimpleDrawer.m
//  
//
//  Created by Roman Stasiv on 12/14/15.
//
//

#import "SimpleDrawer.h"

@interface SimpleDrawer ()

@property (nonatomic, assign) CGPoint lastPoint;

@end

@implementation SimpleDrawer


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(context, 2.0);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextAddEllipseInRect(context, CGRectInset(rect, 2.0, 2.0));
    CGContextStrokePath(context);
}

@end
