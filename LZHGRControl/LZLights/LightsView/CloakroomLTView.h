//
//  CloakroomLTView.h
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloakroomLTView : UIView

-(instancetype)initWithFrame:(CGRect)frame andCloakroom:(Cloakroom *)cloakroom;

- (void)allLightsSwitchIsOpen:(BOOL)isOpen;

@end
