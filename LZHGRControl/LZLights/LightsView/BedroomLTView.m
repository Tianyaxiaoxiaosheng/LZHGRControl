//
//  BedroomLTView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "BedroomLTView.h"

@implementation BedroomLTView

-(instancetype)initWithFrame:(CGRect)frame andBedroomm:(Bedroom *)bedroom
{
    if ([super initWithFrame:frame]) {
        
        //设置界面
        self = [[[NSBundle mainBundle] loadNibNamed:@"BedroomLTView" owner:nil options:nil] lastObject];
        self.frame = frame;
        
        for (NSInteger i = 1; i <= 9; i++) {
            UIButton *button =[self viewWithTag:i];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            //顺便初始化
            switch (button.tag) {
                case 1:
                    button.selected = bedroom.lBedLamp;
                    break;
                case 2:
                    button.selected = bedroom.rBedLamp;
                    break;
                case 3:
                    button.selected = bedroom.lReadingLamp;
                    break;
                case 4:
                    button.selected = bedroom.rReadingLamp;
                    break;
                case 5:
                    button.selected = bedroom.roomLamp;
                    break;
                case 6:
                    button.selected = bedroom.romantic;
                    break;
                case 7:
                    button.selected = bedroom.sleep;
                    break;
                case 8:
                    button.selected = bedroom.working;
                    break;
                case 9:
                    button.selected = bedroom.reception;
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
            sharedDMCore.bedroom.lBedLamp = button.isSelected ? FALSE:TRUE;
            break;
        case 2:
            sharedDMCore.bedroom.rBedLamp = button.isSelected ? FALSE:TRUE;
            break;
        case 3:
            sharedDMCore.bedroom.lReadingLamp = button.isSelected ? FALSE:TRUE;
            break;
        case 4:
            sharedDMCore.bedroom.rReadingLamp = button.isSelected ? FALSE:TRUE;
            break;
        case 5:
            sharedDMCore.bedroom.roomLamp = button.isSelected ? FALSE:TRUE;
            break;
        case 6:
            sharedDMCore.bedroom.romantic = button.isSelected ? FALSE:TRUE;
            break;
        case 7:
            sharedDMCore.bedroom.sleep = button.isSelected ? FALSE:TRUE;
            break;
        case 8:
            sharedDMCore.bedroom.working = button.isSelected ? FALSE:TRUE;
            break;
        case 9:
            sharedDMCore.bedroom.reception = button.isSelected ? FALSE:TRUE;
            break;
            
        default:
            break;
    }
}

- (void)allLightsSwitchIsOpen:(BOOL)isOpen{
    DMCore * sharedDMCore = [DMCore sharedDMCore];
    
    //只控制五个灯
    sharedDMCore.bedroom.lBedLamp = isOpen;
    sharedDMCore.bedroom.rBedLamp = isOpen;
    sharedDMCore.bedroom.lReadingLamp = isOpen;
    sharedDMCore.bedroom.rReadingLamp = isOpen;
    sharedDMCore.bedroom.roomLamp = isOpen;
}


@end
