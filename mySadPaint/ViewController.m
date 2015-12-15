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

@property (weak, nonatomic) IBOutlet SimpleDrawer *figure;
@property (nonatomic, assign) CGPoint startPoint;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [_figure addOperation:@"rect" fromStartPoint:CGPointMake(0, 0) toEndPoint:CGPointMake(100, 100)];
}


#pragma mark - Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    _startPoint.x = [touches.anyObject locationInView:self.view].x;
    _startPoint.y = [touches.anyObject locationInView:self.view].y;
    
    NSLog(@"startsad%f %f", _startPoint.x, _startPoint.y);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    CGPoint endPoint = [touches.anyObject locationInView:self.view];
    
    [self.figure cancelLastOperation];
    [(SimpleDrawer *)self.figure addOperation:@"eclipse"
                               fromStartPoint:self.startPoint
                                   toEndPoint:endPoint];
    NSLog(@"start%f %f", _startPoint.x, _startPoint.y);
    NSLog(@"endpoint%f %f", _startPoint.x, _startPoint.y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    CGPoint endPoint = [touches.anyObject locationInView:self.view];
    [(SimpleDrawer *)self.figure addOperation:@"eclipse"
                               fromStartPoint:self.startPoint
                                   toEndPoint:endPoint];
    NSLog(@"%f %f", _startPoint.x, _startPoint.y);
}



@end
