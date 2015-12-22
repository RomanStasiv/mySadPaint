//
//  PanelColorsViewController.h
//  
//
//  Created by Roman Stasiv on 12/18/15.
//
//

#import <UIKit/UIKit.h>
#import "PanelsProtocols.h"

@interface PanelColorsViewController : UIViewController <ColorPanelProtocol>
- (UIColor *)getSelectedColor;
@property (nonatomic, weak) id<CanvasPropertiesSeting> canvasDelegate;
@end
