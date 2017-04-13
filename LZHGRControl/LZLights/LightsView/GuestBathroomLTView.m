//
//  GuestBathroomLTView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "GuestBathroomLTView.h"

@implementation GuestBathroomLTView

-(instancetype)initWithFrame:(CGRect)frame andGuestBathroom:(GuestBathroom *)guestBathroom
{
    if ([super initWithFrame:frame]) {

        //设置界面
        self = [[[NSBundle mainBundle] loadNibNamed:@"GuestBathroomLTView" owner:nil options:nil] lastObject];
        self.frame = frame;
        
        for (NSInteger i = 1; i <= 3; i++) {
            UIButton *button = [self viewWithTag:i];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            //顺便初始化
            switch (button.tag) {
                case 1:
                    button.selected = guestBathroom.topLamp;
                    break;
                case 2:
                    button.selected = guestBathroom.lightStrip;
                    break;
                case 3:
                    button.selected = guestBathroom.wallLamp;
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
//    if (sharedDMCore.guestBathroom.topLamp) {
//        NSLog(@"sharedDMCore.guestBathroom.topLamp: TRUE");
//    } else {
//        NSLog(@"sharedDMCore.guestBathroom.topLamp: FALSE");
//    }
    switch (button.tag) {
        case 1:
            sharedDMCore.guestBathroom.topLamp = button.isSelected ? FALSE:TRUE;
            break;
        case 2:
            sharedDMCore.guestBathroom.lightStrip = button.isSelected ? FALSE:TRUE;
            break;
        case 3:
            sharedDMCore.guestBathroom.wallLamp = button.isSelected ? FALSE:TRUE;
            break;

            
        default:
            break;
    }
    
}

- (void)allLightsSwitchIsOpen:(BOOL)isOpen{
    DMCore * sharedDMCore = [DMCore sharedDMCore];
    [sharedDMCore.guestBathroom allSwitchIsOpen:isOpen];
//    sharedDMCore.guestBathroom.topLamp = isOpen;
//    sharedDMCore.guestBathroom.lightStrip = isOpen;
//    sharedDMCore.guestBathroom.wallLamp = isOpen;
}

@end
