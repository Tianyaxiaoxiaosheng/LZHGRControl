//
//  MainLampLTView.h
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainLampLTView : UIView

-(instancetype)initWithFrame:(CGRect)frame andMainLamp:(MainLamp *)mainLamp;
- (void)allLightsSwitchIsOpen:(BOOL)isOpen;

@end
