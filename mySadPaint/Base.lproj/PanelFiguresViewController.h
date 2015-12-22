//
//  PanelFiguresViewController.h
//  
//
//  Created by Roman Stasiv on 12/18/15.
//
//

#import <UIKit/UIKit.h>
#import "PanelsProtocols.h"

@interface PanelFiguresViewController : UIViewController <FigurePanelProtocol> 
- (NSString *)getSelectedFigureName;
@property (nonatomic, weak) id<CanvasPropertiesSeting> canvasDelegate;
@end
