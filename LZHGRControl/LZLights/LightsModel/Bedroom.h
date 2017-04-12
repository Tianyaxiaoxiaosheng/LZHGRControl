//
//  Bedroom.h
//  LZHGRControl
//
//  Created by Jony on 17/4/12.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bedroom : NSObject

//switch
@property (nonatomic, assign) BOOL lBedLamp;
@property (nonatomic, assign) BOOL rBedLamp;
@property (nonatomic, assign) BOOL roomLamp;
@property (nonatomic, assign) BOOL lReadingLamp;
@property (nonatomic, assign) BOOL rReadingLamp;

//调光

//mode
@property (nonatomic, assign) BOOL romantic;
@property (nonatomic, assign) BOOL sleep;
@property (nonatomic, assign) BOOL working;
@property (nonatomic, assign) BOOL reception;

@end
