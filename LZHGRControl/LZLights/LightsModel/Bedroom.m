//
//  Bedroom.m
//  LZHGRControl
//
//  Created by Jony on 17/4/12.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "Bedroom.h"

@implementation Bedroom

- (void)allSwitchIsOpen:(BOOL)isOpen{
    self.lBedLamp = isOpen;
    self.rBedLamp = isOpen;
    self.roomLamp = isOpen;
    self.lReadingLamp = isOpen;
    self.rReadingLamp = isOpen;
}

@end
