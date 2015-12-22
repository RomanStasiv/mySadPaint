//
//  CanvasViewController.h
//  
//
//  Created by Roman Stasiv on 12/18/15.
//
//

#import <UIKit/UIKit.h>
#import "PanelsProtocols.h"

@interface CanvasViewController : UIViewController <CanvasPropertiesSeting>
- (void)setColor:(UIColor*) color;
@end
