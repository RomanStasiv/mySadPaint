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




- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    self.curentContext = context;
        
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    for (NSDictionary *temp in self.drawingsToProcede)
    {
        CGPoint startPoint = [[temp valueForKey:@"startPoint"] CGPointValue];
        CGPoint endPoint = [[temp valueForKey:@"endPoint"] CGPointValue];
        CGContextBeginPath(context);
        
        if ([[temp valueForKey:@"operation"] isEqualToString:@"line"])
        {
            CGContextMoveToPoint(context, startPoint.x, startPoint.y);
            CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
        }
        if ([[temp valueForKey:@"operation"] isEqualToString:@"rect"])
        {
            CGContextAddRect(context, CGRectMake(startPoint.x, endPoint.y, (endPoint.x - startPoint.x), (endPoint.y - startPoint.y)));
            CGContextStrokePath(context);
        }
        if ([[temp valueForKey:@"operation"] isEqualToString:@"eclipse"])
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
        
        CGContextStrokePath(context);
    }
}

-(void)addOperation:(NSString*) operation
     fromStartPoint:(CGPoint) startPoint
         toEndPoint:(CGPoint) endPoint
{
    if (self.drawingsToProcede == nil)
        self.drawingsToProcede = [[NSMutableArray alloc] init];
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setObject:operation forKey:@"operation"];
    [temp setObject:[NSValue valueWithCGPoint:startPoint] forKey:@"startPoint"];
    [temp setObject:[NSValue valueWithCGPoint:endPoint] forKey:@"endPoint"];
    
    [self.drawingsToProcede addObject:temp];
    
    [self setNeedsDisplay];
}

-(void)cancelLastOperation
{
    [self.canceleddrawings addObject:[self.drawingsToProcede lastObject]];
    [self.drawingsToProcede removeLastObject];
    
    
    [self setNeedsDisplay];
}

@end
