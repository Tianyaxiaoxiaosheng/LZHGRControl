//
//  AirconKeyboardView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "AirconKeyboardView.h"

@interface AirconKeyboardView ()
@end

@implementation AirconKeyboardView

-(instancetype)initWithFrame:(CGRect)frame andAircon:(Aircon *)aircon
{
    if ([super initWithFrame:frame]) {
        
//        NSLog(@"AirconKeyboardView");
        //设置界面
        self = [[[NSBundle mainBundle] loadNibNamed:@"AirconKeyboardView" owner:nil options:nil] lastObject];
        self.frame = frame;
//        self.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.2];
//        self.layer.cornerRadius = 18;
//        self.layer.masksToBounds = YES;
        
        
        //初始化界面数据
        self.temperatureLabel.text = [NSString stringWithFormat:@"%ld", aircon.temperature];
        
        //此View作为模板使用，因此无法确定是哪个设备的界面，因此按钮的事件无法在此类中操作
//        //创建所有按钮点击事件
//        for (UIButton *button in self.subviews) {
//            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        }
    
    }
    return self;
}

@end
