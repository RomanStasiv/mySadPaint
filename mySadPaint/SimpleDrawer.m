//
//  SimpleDrawer.m
//  
//
//  Created by Roman Stasiv on 12/14/15.
//
//

#import "SimpleDrawer.h"

@interface SimpleDrawer ()

@property (nonatomic, assign)CGPoint lastPoint;
@property (nonatomic, strong)NSMutableArray *drawingsToProcede;

@property (nonatomic, strong)NSMutableArray *canceleddrawings;


@end

@implementation SimpleDrawer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}


-(void)drawSmthngSad:(CGContextRef) context
         withinARect:(CGRect)rect
{
    double R = rect.size.height/2;
    CGContextMoveToPoint(context, rect.size.width/2, 0);
    double alpha = 360/3;
    while (alpha < 360)
    {
        CGContextAddLineToPoint(context, R*cos(alpha*M_PI/180+(rect.size.height/2)), R*sin(alpha*M_PI/180+(rect.size.width/2)));
    }
    CGContextStrokePath(context);
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    CGContextSetLineWidth(context, 2.0); CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    for (NSDictionary *temp in self.drawingsToProcede)
    {
        
        CGPoint startPoint = [[temp valueForKey:@"startPoint"] CGPointValue];
        CGPoint endPoint = [[temp valueForKey:@"endPoint"] CGPointValue];
        CGContextSetStrokeColorWithColor(context, ((UIColor*)[temp objectForKey:@"color"]).CGColor);
        
        CGContextBeginPath(context);
        if ([[temp valueForKey:@"operation"] isEqualToString:@"line"])
        {
            CGContextMoveToPoint(context, startPoint.x, startPoint.y);
            CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
        }
        if ([[temp valueForKey:@"operation"] isEqualToString:@"rect"])
        {
            CGContextAddRect(context, CGRectMake(startPoint.x, startPoint.y, (endPoint.x - startPoint.x), (endPoint.y - startPoint.y)));
            CGContextStrokePath(context);
        }
        if ([[temp valueForKey:@"operation"] isEqualToString:@"ellipse"])
        {
            
            CGContextAddEllipseInRect(context, CGRectMake(startPoint.x, startPoint.y, (endPoint.x - startPoint.x), (endPoint.y-startPoint.y)));
        }
        if ([[temp valueForKey:@"operation"] isEqualToString:@"triangle"])
        {
            CGContextMoveToPoint(context, (startPoint.x + endPoint.x)/2, startPoint.y);
            CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
            CGContextAddLineToPoint(context, startPoint.x, endPoint.y);
            CGContextAddLineToPoint(context, (startPoint.x + endPoint.x)/2, startPoint.y);
        }
        if ([[temp valueForKey:@"operation"] isEqualToString:@"sadness"])
        {
            CGRect nRect = CGRectMake(startPoint.x, startPoint.y, (endPoint.x - startPoint.x), (endPoint.y - startPoint.y));
            
            double R = nRect.size.width/2.f;
            CGContextMoveToPoint(context, R*cos(M_PI*0/180)+R, R*sin(M_PI*0/180)+R);
            double k = 0;
            double n = 100;
            while (k < n+1)
            {
                double alpha = (360.f / n) * k;
                CGContextAddLineToPoint(context, R*cos(M_PI*alpha/180)+R, R*sin(M_PI*alpha/180)+R);
                CGPoint p = CGPointMake(R*cos(M_PI*alpha/180)+R, R*sin(M_PI*alpha/180)+R);
                k++;
            }
        }
        CGContextStrokePath(context);
    }
}

-(void)addOperation:(NSString*) operation
     fromStartPoint:(CGPoint) startPoint
         toEndPoint:(CGPoint) endPoint
          withColor:(UIColor*) color
{
    if (self.drawingsToProcede == nil)
        self.drawingsToProcede = [[NSMutableArray alloc] init];
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:operation forKey:@"operation"];
    [temp setObject:[NSValue valueWithCGPoint:startPoint] forKey:@"startPoint"];
    [temp setObject:[NSValue valueWithCGPoint:endPoint] forKey:@"endPoint"];
    [temp setObject:color forKey:@"color"];
    
    [self.drawingsToProcede addObject:temp];
    
    [self setNeedsDisplay];
}

-(void)changeColor:(UIColor*) color
{
    if (self.drawingsToProcede == nil)
        self.drawingsToProcede = [[NSMutableArray alloc] init];
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:@"colorChange" forKey:@"operation"];
    [temp setObject:color forKey:@"color"];
    
    [self.drawingsToProcede addObject:temp];
    
    [self setNeedsDisplay];
}

-(void)setRect:(CGRect) rect
         withN:(NSInteger) N
{

}

-(void)cancelLastOperation
{
    [self.canceleddrawings addObject:[self.drawingsToProcede lastObject]];
    NSLog(@"canceled:%@", [[self.drawingsToProcede lastObject] valueForKey:@"operation"]);
    [self.drawingsToProcede removeLastObject];
    
    
    [self setNeedsDisplay];
}



@end
