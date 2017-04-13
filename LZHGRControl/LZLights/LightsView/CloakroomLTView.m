//
//  CloakroomLTView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "CloakroomLTView.h"

@implementation CloakroomLTView

-(instancetype)initWithFrame:(CGRect)frame andCloakroom:(Cloakroom *)cloakroom
{
    if ([super initWithFrame:frame]) {
        
        //设置界面
        self = [[[NSBundle mainBundle] loadNibNamed:@"CloakroomLTView" owner:nil options:nil] lastObject];
        self.frame = frame;
        
        for (NSInteger i = 1; i <= 2; i++) {
            UIButton *button =[self viewWithTag:i];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            //顺便初始化
            switch (button.tag) {
                case 1:
                    button.selected = cloakroom.topLamp;
                    break;
                case 2:
                    button.selected = cloakroom.lightStrip;
                    break;
                    
                default:
                    break;
            }
        }
    }
    return self;
}

- (void)buttonClicked:(UIButton *)button{
    DMCore * sharedDMCore = [DMCore sharedDMCore];
    switch (button.tag) {
        case 1:
            sharedDMCore.cloakroom.topLamp = button.isSelected ? FALSE:TRUE;
            break;
        case 2:
            sharedDMCore.cloakroom.lightStrip = button.isSelected ? FALSE:TRUE;
            break;
            
        default:
            break;
    }
}

- (void)allLightsSwitchIsOpen:(BOOL)isOpen{
    DMCore * sharedDMCore = [DMCore sharedDMCore];
    [sharedDMCore.cloakroom allSwitchIsOpen:isOpen];
//    sharedDMCore.cloakroom.topLamp = isOpen;
//    sharedDMCore.cloakroom.lightStrip = isOpen;
}

@end
