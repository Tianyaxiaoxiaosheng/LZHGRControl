//
//  AirconKeyboardView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "AirconKeyboardView.h"

@interface AirconKeyboardView ()
@property (nonatomic, strong) Aircon *tempAircon;
@property (weak, nonatomic) IBOutlet UIButton *parlorACBut;
@property (weak, nonatomic) IBOutlet UIButton *bedroomACBut;
@property (weak, nonatomic) IBOutlet UILabel *TLabel;

@end

@implementation AirconKeyboardView

-(instancetype)initWithFrame:(CGRect)frame andParlorAC:(Aircon *)parlorAC BedroomAC:(Aircon *)bedroomAC
{
    if ([super initWithFrame:frame]) {
        //设置界面
        self = [[[NSBundle mainBundle] loadNibNamed:@"AirconKeyboardView" owner:nil options:nil] lastObject];
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.2];
        self.layer.cornerRadius = 18;
        self.layer.masksToBounds = YES;
        
        //数据对接
        self.parlorAC = parlorAC;
        self.bedroomAC = bedroomAC;
        
        //初始化界面数据
        self.bedroomACBut.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.4];
        self.tempAircon = self.parlorAC;
        self.parlorACBut.enabled = NO;
        [self initViewWithAircon:self.tempAircon];
    }
    return self;
}

- (void)initViewWithAircon:(Aircon *)aircon
{
    self.TLabel.text = [NSString stringWithFormat:@"%ld",aircon.temperature];
}

- (IBAction)parlorACButClick:(UIButton *)sender {
    self.bedroomACBut.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.4];
    sender.backgroundColor= [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0];
    self.bedroomACBut.enabled = YES;
    self.parlorACBut.enabled = NO;

    
    self.bedroomAC = self.tempAircon;
    self.tempAircon = self.parlorAC;
    
    [self initViewWithAircon:self.tempAircon];
}
- (IBAction)bedroomACBut:(UIButton *)sender {
    self.parlorACBut.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.4];
    sender.backgroundColor= [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0];
    
    self.parlorACBut.enabled = YES;
    self.bedroomACBut.enabled = NO;
    
    self.parlorAC = self.tempAircon;
    self.tempAircon = self.bedroomAC;
    
    [self initViewWithAircon:self.tempAircon];
}

- (IBAction)temperatureAdd:(id)sender {
    
    //test sharedDMCore
    DMCore *sharedDMCore = [DMCore sharedDMCore];
    NSLog(@"%ld",sharedDMCore.BRAircon.temperature);
    self.tempAircon.temperature++;
    [self initViewWithAircon:self.tempAircon];
}
- (IBAction)temperatureReduce:(id)sender {
    self.tempAircon.temperature--;
    [self initViewWithAircon:self.tempAircon];
}


@end
