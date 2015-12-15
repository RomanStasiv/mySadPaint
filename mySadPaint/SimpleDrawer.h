//
//  SimpleDrawer.h
//  
//
//  Created by Roman Stasiv on 12/14/15.
//
//

#import <UIKit/UIKit.h>

@interface SimpleDrawer : UIView

@property (nonatomic, assign) CGContextRef curentContext;
-(void)addOperation:(NSString*) operation
     fromStartPoint:(CGPoint) startPoint
         toEndPoint:(CGPoint) endPoint;
-(void)cancelLastOperation;


@end
