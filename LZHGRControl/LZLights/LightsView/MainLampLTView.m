//
//  MainLampLTView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "MainLampLTView.h"

@implementation MainLampLTView

-(instancetype)initWithFrame:(CGRect)frame andMainLamp:(MainLamp *)mainLamp
{
    if ([super initWithFrame:frame]) {
        
        //设置界面
        self = [[[NSBundle mainBundle] loadNibNamed:@"MainLampLTView" owner:nil options:nil] lastObject];
        self.frame = frame;
        
        for (NSInteger i = 1; i <= 4; i++) {
            UIButton *button =[self viewWithTag:i];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            //顺便初始化
            switch (button.tag) {
                case 1:
                    button.selected = mainLamp.roomLamp;
                    break;
                case 2:
                    button.selected = mainLamp.corridor;
                    break;
                case 3:
                    button.selected = mainLamp.working;
                    break;
                case 4:
                    button.selected = mainLamp.reception;
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
                sharedDMCore.mainLamp.roomLamp = button.isSelected ? FALSE:TRUE;
                break;
            case 2:
                sharedDMCore.mainLamp.corridor = button.isSelected ? FALSE:TRUE;
                break;
            case 3:
                sharedDMCore.mainLamp.working = button.isSelected ? FALSE:TRUE;
                break;
            case 4:
                sharedDMCore.mainLamp.reception = button.isSelected ? FALSE:TRUE;
                break;
    
            default:
                break;
        }
}

- (void)allLightsSwitchIsOpen:(BOOL)isOpen{
    DMCore * sharedDMCore = [DMCore sharedDMCore];
    [sharedDMCore.mainLamp allSwitchIsOpen:isOpen];
//        sharedDMCore.mainLamp.roomLamp = isOpen;
//        sharedDMCore.mainLamp.corridor = isOpen;
}


@end
