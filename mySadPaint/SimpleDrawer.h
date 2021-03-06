//
//  SimpleDrawer.h
//  
//
//  Created by Roman Stasiv on 12/14/15.
//
//

#import <UIKit/UIKit.h>
#import "DataSerializer.h"


@interface SimpleDrawer : UIView

@property (nonatomic, assign) CGContextRef curentContext;
-(void)addOperation:(NSString*) operation
     fromStartPoint:(CGPoint) startPoint
         toEndPoint:(CGPoint) endPoint
          withColor:(UIColor*) color;
-(void)addPointToPencilTray:(CGPoint)point;
-(void)cancelLastOperationWithSaving: (BOOL) save;
-(void)saveToFile: (NSString *) path;
-(void)readFromFile:(NSString *) path;

@end
