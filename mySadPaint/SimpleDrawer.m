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
            
            NSLog(@"%f%f", startPoint.x, startPoint.y);
            
            double R = nRect.size.width/2.f;
            CGContextMoveToPoint(context, startPoint.x + R*cos(M_PI*0/180)+R, startPoint.y + R*sin(M_PI*0/180)+R);
            double k = 0;
            double n = 5.f;
            while (k < n+1)
            {
                double alpha = (360.f / n) * k;
                CGContextAddLineToPoint(context, startPoint.x + R*cos(M_PI*alpha/180)+R, startPoint.y + R*sin(M_PI*alpha/180)+R);
                k++;
            }
        }
        if ([[temp valueForKey:@"operation"] isEqualToString:@"image"])
        {
            NSData *data = [NSData dataWithContentsOfFile:@"//Users//romanstasiv//Desktop//satan.jpg"
                                                  options:NSDataReadingUncached
                                                    error:nil];
            UIImage *img = [UIImage imageWithData:data];
            
            [img drawInRect:CGRectMake(startPoint.x, startPoint.y, endPoint.x - startPoint.x, endPoint.y - startPoint.y) ];
            
        }
        if([[temp valueForKey:@"operation"] isEqualToString:@"pencil"])
        {
            NSArray * points = [temp valueForKey:@"points"];
            CGContextMoveToPoint(context, startPoint.x, startPoint.y);
            for (NSValue * temp in points )
            {
                CGPoint curentPoint = [temp CGPointValue];
                CGContextAddLineToPoint(context, curentPoint.x, curentPoint.y);
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

-(void) addPointToPencilTray:(CGPoint)point
{
    if ([[[self.drawingsToProcede lastObject] valueForKey:@"operation"] isEqualToString:@"pencil"])
    {
        if ([[self.drawingsToProcede lastObject] valueForKey:@"points"] == nil )
        {
            [[self.drawingsToProcede lastObject] setValue:[[NSMutableArray alloc] init] forKey:@"points"];
        }
        [[[self.drawingsToProcede lastObject] valueForKey:@"points"] addObject:[NSValue valueWithCGPoint:point]];
    }
    [self setNeedsDisplay];
}

-(void)cancelLastOperationWithSaving: (BOOL) save
{
    if (save)
    {
        [self.canceleddrawings addObject:[self.drawingsToProcede lastObject]];
        NSLog(@"canceled:%@", [[self.drawingsToProcede lastObject] valueForKey:@"operation"]);
    }
    [self.drawingsToProcede removeLastObject];
    [self setNeedsDisplay];
}

-(void) saveToFile:(NSString *) path
{
    [DataSerializer serializeArray:self.drawingsToProcede toFile:path];
    NSLog(@"before: %@", self.drawingsToProcede);
}


-(void) readFromFile:(NSString *) path
{
    self.drawingsToProcede = [DataSerializer readArrayFromFile:path];
    
    NSLog(@"after: %@", self.drawingsToProcede);
    [self setNeedsDisplay];
}
@end
