//
//  ToletLTView.h
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToletLTView : UIView

-(instancetype)initWithFrame:(CGRect)frame andTolet:(Tolet *)tolet;
- (void)allLightsSwitchIsOpen:(BOOL)isOpen;

@end
