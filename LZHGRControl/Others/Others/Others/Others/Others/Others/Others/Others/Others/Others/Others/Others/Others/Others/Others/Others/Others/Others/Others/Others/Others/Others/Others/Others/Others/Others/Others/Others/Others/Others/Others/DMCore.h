//
//  DMCore.h
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMCore : NSObject
@property (nonatomic, strong) Aircon *PLAircon;
@property (nonatomic, strong) Aircon *BRAircon;

//单例模式
+ (instancetype)sharedDMCore;

@end
