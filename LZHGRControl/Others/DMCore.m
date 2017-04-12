//
//  DMCore.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "DMCore.h"

@implementation DMCore

#pragma mark-确保被创建一次
static DMCore *sharedDMCore = nil;

+ (instancetype)sharedDMCore{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDMCore = [super allocWithZone:zone];
    });
    return sharedDMCore;
}

- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDMCore = [super init];
    });
    return sharedDMCore;
}

- (id)copyWithZone:(NSZone *)zone{
    return  sharedDMCore;
}
+ (id)copyWithZone:(struct _NSZone *)zone{
    return  sharedDMCore;
}
+ (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return sharedDMCore;
}
- (id)mutableCopyWithZone:(NSZone *)zone{
    return sharedDMCore;
}

#pragma mark-懒加载对象
//lazyload some init data
- (Aircon *)PLAircon{
    if (!_PLAircon) {
        _PLAircon = [[Aircon alloc] init];
        _PLAircon.temperature = 0;
    }
    return _PLAircon;
}

- (Aircon *)BRAircon{
    if (!_BRAircon) {
        _BRAircon = [[Aircon alloc] init];
        _BRAircon.temperature = -50;
    }
    return _BRAircon;
}

- (Cloakroom *)cloakroom{
    if (!_cloakroom) {
        _cloakroom = [[Cloakroom alloc] init];
        _cloakroom.topLamp = TRUE;
        _cloakroom.lightStrip = FALSE;
    }
    return _cloakroom;
}

- (GuestBathroom *)guestBathroom{
    if (!_guestBathroom) {
        _guestBathroom = [[GuestBathroom alloc] init];
        _guestBathroom.topLamp = TRUE;
        _guestBathroom.lightStrip = FALSE;
        _guestBathroom.wallLamp = TRUE;
    }
    return _guestBathroom;
}

@end
