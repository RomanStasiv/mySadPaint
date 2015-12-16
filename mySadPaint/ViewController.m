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
@property (nonatomic, strong) NSString *selectedOperation;
@property (nonatomic, strong) UIColor *selectedColor;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedOperation = @"line";
    self.selectedColor = [UIColor redColor];

}
- (IBAction)operationChanged:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0: self.selectedOperation = @"line";
            break;
        case 1: self.selectedOperation = @"rect";
            break;
        case 2: self.selectedOperation = @"triangle";
            break;
        case 3: self.selectedOperation = @"eclipse";
            break;
    }
}
- (IBAction)colorChanged:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0: self.selectedColor = [UIColor redColor];
            break;
        case 1: self.selectedColor = [UIColor greenColor];
            break;
        case 2: self.selectedColor = [UIColor blueColor];
            break;
    }
}
- (IBAction)cancel
{
    [self.figure cancelLastOperation];
}


#pragma mark - Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    _startPoint.x = [touches.anyObject locationInView:self.view].x;
    _startPoint.y = [touches.anyObject locationInView:self.view].y;
    [(SimpleDrawer *)self.figure addOperation:self.selectedOperation
                               fromStartPoint:self.startPoint
                                   toEndPoint:self.startPoint
                                    withColor:self.selectedColor];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    CGPoint endPoint = [touches.anyObject locationInView:self.view];
    
    [self.figure cancelLastOperation];
    [(SimpleDrawer *)self.figure addOperation:self.selectedOperation
                               fromStartPoint:self.startPoint
                                   toEndPoint:endPoint
                                    withColor:self.selectedColor];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    CGPoint endPoint = [touches.anyObject locationInView:self.view];
    [self.figure cancelLastOperation];
    [(SimpleDrawer *)self.figure addOperation:self.selectedOperation
                               fromStartPoint:self.startPoint
                                   toEndPoint:endPoint
                                    withColor:self.selectedColor];
}



@end
