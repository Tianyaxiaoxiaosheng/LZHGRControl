//
//  GuestBathroomLTView.h
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuestBathroomLTView : UIView

-(instancetype)initWithFrame:(CGRect)frame andGuestBathroom:(GuestBathroom *)guestBathroom;

- (void)allLightsSwitchIsOpen:(BOOL)isOpen;

@end
