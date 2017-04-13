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
//当数据不进行初始化时，bool的属性为空

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

- (Bedroom *)bedroom{
    if (!_bedroom) {
        _bedroom = [[Bedroom alloc] init];
        _bedroom.lBedLamp = TRUE;
        _bedroom.rBedLamp = FALSE;
        _bedroom.lReadingLamp = TRUE;
        _bedroom.lReadingLamp = FALSE;
        _bedroom.roomLamp = TRUE;
        
        _bedroom.romantic = FALSE;
        _bedroom.sleep = FALSE;
        _bedroom.working = FALSE;
        _bedroom.reception = FALSE;
    }
    return _bedroom;
}

- (MainLamp *)mainLamp{
    if (!_mainLamp) {
        _mainLamp = [[MainLamp alloc] init];
        _mainLamp.roomLamp = FALSE;
        _mainLamp.corridor = TRUE;
        _mainLamp.working = TRUE;
        _mainLamp.reception = FALSE;
    }
    return _mainLamp;
}

- (Tolet *)tolet{
    if (!_tolet) {
        _tolet = [[Tolet alloc] init];
        _tolet.wallLamp = TRUE;
        _tolet.sPA = FALSE;
    }
    return _tolet;
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
