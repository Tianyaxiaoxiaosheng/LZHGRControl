//
//  SetKeyboardView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "SetKeyboardView.h"

@interface SetKeyboardView ()
@property (weak, nonatomic) IBOutlet UISwitch *sw;

@end

@implementation SetKeyboardView

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"SetKeyboardView" owner:nil options:nil] lastObject];
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.2];
        self.layer.cornerRadius = 18;
        self.layer.masksToBounds = YES;
    }
    return self;
}
- (IBAction)swValueChanged:(id)sender{
    [DMCore sharedDMCore].PLAircon.temperature++;
    if ([(UISwitch *)sender isOn]) {
        
        NSLog(@"switch ON");
        [[UDPNetwork sharedUDPNetwork] startReceiveNetworkData];
        
     }else{
        NSLog(@"switch OFF");
    }
}
- (IBAction)butClick:(id)sender {
    if ([self.sw isOn]) {
        self.sw.on = YES;
    } else {
        self.sw.on = NO;
    }
}


@end
