//
//  ViewController.m
//  mySadPaint
//
//  Created by Roman Stasiv on 12/14/15.
//  Copyright (c) 2015 Roman Stasiv. All rights reserved.
//

#import "ViewController.h"
#import "SimpleDrawer.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *figure;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    SimpleDrawer *rect = [[SimpleDrawer alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
    [self.view addSubview:rect];
    
}


#pragma mark - Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    CGPoint point = [touches.anyObject locationInView:self.view];
    
    for (UIView *view in self.view.subviews)
    {
        if (CGRectContainsPoint(view.frame, point))
        {
            self.figure = view;
            break;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    CGPoint point = [touches.anyObject locationInView:self.view];
    
    self.figure.center = point;
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    self.figure = nil;
}



@end
