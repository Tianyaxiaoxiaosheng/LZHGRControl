//
//  ToletLTView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "ToletLTView.h"

@implementation ToletLTView

-(instancetype)initWithFrame:(CGRect)frame andTolet:(Tolet *)tolet
{
    if ([super initWithFrame:frame]) {
        
        //设置界面
        self = [[[NSBundle mainBundle] loadNibNamed:@"ToletLTView" owner:nil options:nil] lastObject];
        self.frame = frame;
        
        for (NSInteger i = 1; i <= 2; i++) {
            UIButton *button =[self viewWithTag:i];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            //顺便初始化
            switch (button.tag) {
                case 1:
                    button.selected = tolet.wallLamp;
                    break;
                case 2:
                    button.selected = tolet.sPA;
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
                sharedDMCore.tolet.wallLamp = TRUE;
                break;
            case 2:
                sharedDMCore.tolet.sPA = button.isSelected ? FALSE:TRUE;
                break;
    
            default:
                break;
        }
//    NSLog(@"sharedDMCore.tolet: %ld",button.tag);
//    if (sharedDMCore.tolet.wallLamp) {
//        NSLog(@"sharedDMCore.tolet.wallLamp: true");
//    } else {
//        NSLog(@"sharedDMCore.tolet.wallLamp: false");
//    }

}

- (void)allLightsSwitchIsOpen:(BOOL)isOpen{
//    NSLog(@"allLightsSwitchIsOpen:(BOOL)isOpen");
    DMCore * sharedDMCore = [DMCore sharedDMCore];
    [sharedDMCore.tolet allSwitchIsOpen:isOpen];
//        sharedDMCore.tolet.wallLamp = isOpen;
}


@end
