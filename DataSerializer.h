//
//  DataSerializer.h
//  mySadPaint
//
//  Created by Roman Stasiv on 12/23/15.
//  Copyright (c) 2015 Roman Stasiv. All rights reserved.
//

#ifndef mySadPaint_DataSerializer_h
#define mySadPaint_DataSerializer_h
#import <UIKit/UIKit.h>

@interface DataSerializer : NSObject

+(void) serializeArray: (NSArray*) arr toFile: (NSString*) path;
+(NSMutableArray* ) readArrayFromFile: (NSString*) path;

@end

#endif
