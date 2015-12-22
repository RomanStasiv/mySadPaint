//
//  PanelsProtocols.h
//  mySadPaint
//
//  Created by Roman Stasiv on 12/21/15.
//  Copyright (c) 2015 Roman Stasiv. All rights reserved.
//

#ifndef mySadPaint_PanelsProtocols_h
#define mySadPaint_PanelsProtocols_h
#import "SimpleDrawer.h"
@protocol ColorPanelProtocol <NSObject>
- (UIColor *)getSelectedColor;
@end
@protocol FigurePanelProtocol <NSObject>
- (NSString *)getSelectedFigureName;
@end

@protocol CanvasPropertiesSeting <NSObject>
- (void)setFigureType: (NSString*) figure;
- (void)setColor: (UIColor*) color;
- (void)cancelLastFigure;
@end


#endif
