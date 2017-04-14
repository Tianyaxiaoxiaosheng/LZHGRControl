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
        self.roomNumTextField.keyboardType = UIKeyboardTypeDecimalPad; //数字键盘 有数字和小数点
        self.roomNumTextField.placeholder = @"4位数字"; //水印
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

#pragma mark - 按钮事件

- (IBAction)cancel:(id)sender {
      self.ipTextField.text = [self.sharedUDPNetwork.networkInfoDic objectForKey:@"host"];
}
- (IBAction)preserve:(id)sender {
    //保存前检查IP地址规范
    if (![self isIPAddressWithString:self.ipTextField.text]) {
        NSLog(@"IP地址不符合规范");
        return;
    }
    
    [self.sharedUDPNetwork.networkInfoDic setValue:self.ipTextField.text forKey:@"host"];
    
    if ([self.sharedUDPNetwork renewLocalNetworkInfo]) {
        NSLog(@"保存成功");
    }else{
        NSLog(@"保存失败");
    }

}

#pragma mark - 文本处理
- (NSString *)buildIPStringWithString:(NSString *)string{
   
    //检查数据规范
    if (![self isFourBitOfRoomNumbersWithString:string]) {
        return [self.sharedUDPNetwork.networkInfoDic objectForKey:@"host"];
    }
    
    NSString *precedTwoSubStr = [string substringToIndex:2];
    NSString *backTwoSubStr = [string substringFromIndex:2];
    
    return [NSString stringWithFormat:@"192.168.%@.%@", precedTwoSubStr, backTwoSubStr];
    
}

//检查四位的房间号是否符合规范
- (BOOL)isFourBitOfRoomNumbersWithString:(NSString *)string{
    if (string.length > 4) {
        return false;
    }
    
    for (NSInteger i = 0; i < string.length; i++) {
        unichar charactor = [string characterAtIndex:i];
        if (!(charactor  >= 48 && charactor  <=57)) {
            return false;
        }
    }
    return true;
}

//检查ip地址是否符合规范
- (BOOL)isIPAddressWithString:(NSString *)string{
    if (string.length > 15) {
        return false;
    }
    
    NSInteger from = 0; //记录截取的初始位置
    NSInteger cutCount = 0; //记录截取次数
    NSInteger length = string.length;
//    NSInteger to   = 0; //截取长度i-from+1
    
    for (NSInteger i = 0; i < length; i++) {
        unichar charactor = [string characterAtIndex:i];
        
        //判断字符规范
        if ( !((charactor>= 48 && charactor<=57) || charactor==46) ) {
            return false;
        }
        
        //截取，判读是否在ip地址范围
        if ((charactor==46) || (i==length-1)) {
            NSInteger tempInt = [[string substringWithRange:NSMakeRange(from, (i-from+1))] integerValue];
            //NSLog(@"%ld", tempInt);
            if (!(tempInt >= 0 && tempInt <= 255)) {
                return false;
            }
            from = i+1;
            cutCount++;
        }
    }
    
    //判断截取次数是否满足
    if (cutCount != 4) {
        return false;
    }
    
    //通过所有检测
    return true;
}

#pragma mark - textField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
//    NSLog(@"rang: from %ld  to %ld ",range.location, range.length);
    
    if (self.ipTextField == textField)  //判断是否时我们想要限定的那个输入框
     {
        if ([toBeString length] > 15) { //如果输入框内容大于14则弹出警告
            NSLog(@"ipTextField 超过最大数");
             return NO;
        }
    }
    
    if (self.roomNumTextField == textField) {
        if ([toBeString length] == 4) {
            self.ipTextField.text = [self buildIPStringWithString:toBeString];
        }
        
        if ([toBeString length] > 4) { //如果输入框内容大于3则弹出警告
            NSLog(@"roomNumTextField 超过最大数");
            return NO;
        }
    }
    return YES;
}



@end
