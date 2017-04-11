//
//  ACNavigationView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "ACNavigationView.h"

@implementation ACNavigationView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        //设置界面
        self = [[[NSBundle mainBundle] loadNibNamed:@"ACNavigationView" owner:nil options:nil] lastObject];
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.2];
        self.layer.cornerRadius = 18;
        self.layer.masksToBounds = YES;
        
        //初始化界面数据
        self.bedroomACBut.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.2];
        self.parlorACBut.enabled = NO;
    }
    return self;
}

@end
