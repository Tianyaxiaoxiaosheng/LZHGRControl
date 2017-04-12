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

@property (nonatomic, strong) Bedroom *bedroom;
@property (nonatomic, strong) MainLamp *mainLamp;
@property (nonatomic, strong) Tolet *tolet;
@property (nonatomic, strong) Cloakroom *cloakroom;
@property (nonatomic, strong) GuestBathroom *guestBathroom;

//单例模式
+ (instancetype)sharedDMCore;

@end
