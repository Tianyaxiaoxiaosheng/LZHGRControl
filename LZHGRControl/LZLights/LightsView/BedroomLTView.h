//
//  BedroomLTView.h
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BedroomLTView : UIView

-(instancetype)initWithFrame:(CGRect)frame andBedroomm:(Bedroom *)bedroom;
- (void)allLightsSwitchIsOpen:(BOOL)isOpen;

@end
