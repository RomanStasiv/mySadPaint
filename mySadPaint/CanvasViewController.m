//
//  CanvasViewController.m
//  
//
//  Created by Roman Stasiv on 12/18/15.
//
//

#import "CanvasViewController.h"


@interface CanvasViewController()
@property (weak, nonatomic) IBOutlet SimpleDrawer *drawer;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) NSString *selectedFigureType;
@end

@implementation CanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedFigureType = @"line";
    self.selectedColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setColor:(UIColor*) color
{
    self.selectedColor = color;
}
- (void)setFigureType:(NSString *)figure
{
    self.selectedFigureType = figure;
}
- (void)cancelLastFigure
{
    [self.drawer cancelLastOperation];
}


#pragma mark - Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    _startPoint.x = [touches.anyObject locationInView:self.view].x;
    _startPoint.y = [touches.anyObject locationInView:self.view].y;
    [(SimpleDrawer *)self.drawer addOperation:self.selectedFigureType
                               fromStartPoint:self.startPoint
                                   toEndPoint:self.startPoint
                                    withColor:self.selectedColor];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    CGPoint endPoint = [touches.anyObject locationInView:self.view];
    if ([self.selectedFigureType isEqualToString:@"pencil"])
    {
        [self.drawer addPointToPencilTray:endPoint];
    }
    else
    {
        [self.drawer cancelLastOperation];
        [(SimpleDrawer *)self.drawer addOperation:self.selectedFigureType
                                   fromStartPoint:self.startPoint
                                       toEndPoint:endPoint
                                        withColor:self.selectedColor];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    CGPoint endPoint = [touches.anyObject locationInView:self.view];
    
    if ([self.selectedFigureType isEqualToString:@"pencil"])
    {
        [self.drawer addPointToPencilTray:endPoint];
    }
    else
    {
        [self.drawer cancelLastOperation];
        [(SimpleDrawer *)self.drawer addOperation:self.selectedFigureType
                                   fromStartPoint:self.startPoint
                                       toEndPoint:endPoint
                                        withColor:self.selectedColor];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
