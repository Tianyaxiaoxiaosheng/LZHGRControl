//
//  SetKeyboardView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "SetKeyboardView.h"
//#define IP_TEXT @”.0123456789”
//#define ROOMNUBER @”0123456789”

@interface SetKeyboardView ()<UITextFieldDelegate>
@property (nonatomic, strong) UDPNetwork *sharedUDPNetwork;
@property (weak, nonatomic) IBOutlet UITextField *ipTextField;
@property (weak, nonatomic) IBOutlet UITextField *roomNumTextField;
@property (weak, nonatomic) IBOutlet UISwitch *sw;

@end

@implementation SetKeyboardView
- (UDPNetwork *)sharedUDPNetwork{
    if (!_sharedUDPNetwork) {
        _sharedUDPNetwork = [UDPNetwork sharedUDPNetwork];
    }
    return _sharedUDPNetwork;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"SetKeyboardView" owner:nil options:nil] lastObject];
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.2];
        self.layer.cornerRadius = 18;
        self.layer.masksToBounds = YES;
        
        //初始化ip显示
        self.ipTextField.text = [self.sharedUDPNetwork.networkInfoDic objectForKey:@"host"];
        self.ipTextField.clearButtonMode = UITextFieldViewModeAlways;
        self.ipTextField.clearsOnBeginEditing = YES;
        self.ipTextField.keyboardType = UIKeyboardTypeDecimalPad;
        self.ipTextField.delegate = self;
        
        //房间号
        self.roomNumTextField.clearButtonMode = UITextFieldViewModeAlways;
        self.roomNumTextField.clearsOnBeginEditing = YES;
        self.roomNumTextField.keyboardType = UIKeyboardTypeDecimalPad;
        self.roomNumTextField.delegate = self;
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

- (IBAction)cancel:(id)sender {
      self.ipTextField.text = [self.sharedUDPNetwork.networkInfoDic objectForKey:@"host"];
}
- (IBAction)preserve:(id)sender {
    [self.sharedUDPNetwork.networkInfoDic setValue:self.ipTextField.text forKey:@"host"];
    
    if ([self.sharedUDPNetwork renewLocalNetworkInfo]) {
        NSLog(@"保存成功");
    }else{
        NSLog(@"保存失败");
    }

}

#pragma mark - textField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    
    if (self.ipTextField == textField)  //判断是否时我们想要限定的那个输入框
     {
        if ([textField.text length] > 14) { //如果输入框内容大于20则弹出警告
            NSLog(@"ipTextField 超过最大数");
             return NO;
        }
    }
    
    if (self.roomNumTextField == textField) {
        if ([textField.text length] > 3) { //如果输入框内容大于20则弹出警告
            NSLog(@"roomNumTextField 超过最大数");
            return NO;
        }
    }
    return YES;
}



@end
