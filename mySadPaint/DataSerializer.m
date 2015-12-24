//
//  DataSerializer.m
//  
//
//  Created by Roman Stasiv on 12/23/15.
//
//

#import <Foundation/Foundation.h>
#import "DataSerializer.h"

@interface DataSerializer ()

@end

@implementation DataSerializer : NSObject

+(void)serializeArray:(NSArray *)arr toFile:(NSString *)path
{
    NSMutableArray *preparedForSerializationArray = [[NSMutableArray alloc] init];
    
    for (id temp in arr)
    {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        
        [dictionary setValue:[temp valueForKey:@"operation"] forKey:@"operation"];
        
        
        NSMutableArray *pointArr = [[NSMutableArray alloc] init];
        
        NSValue *startPoint = [temp valueForKey:@"startPoint"];
        [pointArr addObject:[NSNumber numberWithDouble:[startPoint CGPointValue].x] ];
        [pointArr addObject:[NSNumber numberWithDouble:[startPoint CGPointValue].y] ];
        [dictionary setValue:pointArr forKey:@"startPoint"];
        pointArr = [[NSMutableArray alloc] init];
        
        NSValue *endPoint = [temp valueForKey:@"endPoint"];
        [pointArr addObject:[NSNumber numberWithDouble:[endPoint CGPointValue].x] ];
        [pointArr addObject:[NSNumber numberWithDouble:[endPoint CGPointValue].y] ];
        [dictionary setValue:pointArr forKey:@"endPoint"];
        pointArr = [[NSMutableArray alloc] init];
        
        NSMutableArray *allPointsArray = [[NSMutableArray alloc] init];
        for (NSValue *point in [temp valueForKey:@"points"])
        {
            [pointArr addObject:[NSNumber numberWithDouble:[point CGPointValue].x] ];
            [pointArr addObject:[NSNumber numberWithDouble:[point CGPointValue].y] ];
            [allPointsArray addObject:pointArr];
            pointArr = [[NSMutableArray alloc] init];
        }
        
        [dictionary setValue:allPointsArray forKey:@"points"];
        
        [dictionary setValue:[[temp valueForKey:@"color"] description] forKey:@"color"];
        
        [preparedForSerializationArray addObject:dictionary];
    }
    
    
    //NSString *fileName = @"//Users//romanstasiv//Desktop//somejson.dat";
    
    if ([NSJSONSerialization isValidJSONObject:preparedForSerializationArray])
    {
        NSOutputStream *os = [[NSOutputStream alloc] initToFileAtPath:path
                                                               append:NO];
    
        [os open];
        [NSJSONSerialization writeJSONObject:preparedForSerializationArray
                                    toStream:os options:0
                                       error:nil];
        [os close];
    }
}

+(NSMutableArray* ) readArrayFromFile: (NSString*) path
{
    //NSString *filePath = @"//Users//romanstasiv//Desktop//somejson.dat";
    
    
    
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    
    NSMutableArray *jsonArr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:0
                                                                error:nil];
    
    NSMutableArray *drawingsArr = [[NSMutableArray alloc] init];
    
    for (id temp in jsonArr)
    {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        
        [dictionary setObject:[temp valueForKey:@"operation"]
                       forKey:@"operation"];
        
        [dictionary setObject:[NSValue valueWithCGPoint:CGPointMake([[[temp valueForKey:@"startPoint"] firstObject] floatValue], [[[temp valueForKey:@"startPoint"] lastObject] floatValue])]
                       forKey:@"startPoint"];
        
        [dictionary setObject:[NSValue valueWithCGPoint:CGPointMake([[[temp valueForKey:@"endPoint"] firstObject] floatValue], [[[temp valueForKey:@"endPoint"] lastObject] floatValue])]
                       forKey:@"endPoint"];
        
        
        NSMutableArray *pointsArray = [[NSMutableArray alloc] init];
        for (id point in [temp valueForKey:@"points"])
        {
            [pointsArray addObject:[NSValue valueWithCGPoint:CGPointMake([[point firstObject] floatValue], [[point lastObject] floatValue])]];
        }
        
        [dictionary setObject:pointsArray forKey:@"points"];
        
        
        NSArray *RGBColorComponents = [[temp valueForKey:@"color"] componentsSeparatedByString:@" "];
        
        [dictionary setObject: [UIColor colorWithRed:[[RGBColorComponents objectAtIndex:1] floatValue]
                                               green:[[RGBColorComponents objectAtIndex:2] floatValue]
                                                blue:[[RGBColorComponents objectAtIndex:3] floatValue]
                                               alpha:[[RGBColorComponents objectAtIndex:4] floatValue]]
                       forKey:@"color"];
        
        [drawingsArr addObject:dictionary];
    }
    
    
    return drawingsArr;
}


@end