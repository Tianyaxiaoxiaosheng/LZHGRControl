//
//  ServerKeyboardView.m
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "ServerKeyboardView.h"

@interface ServerKeyboardView ()
@property (weak, nonatomic) IBOutlet UIButton *noFazeBut;
@property (weak, nonatomic) IBOutlet UIButton *waitBut;
@property (weak, nonatomic) IBOutlet UIButton *sosBut;


@end

@implementation ServerKeyboardView

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ServerKeyboardView" owner:nil options:nil] lastObject];
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.2];
        self.layer.cornerRadius = 18;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (IBAction)noFazeButtonClicked:(UIButton *)sender {
    sender.selected = sender.isSelected ? FALSE :TRUE;
  }
- (IBAction)waitButtonClicked:(UIButton *)sender {
        sender.selected = sender.isSelected ? FALSE :TRUE;
}
- (IBAction)sosButtonClicked:(UIButton *)sender {
        sender.selected = sender.isSelected ? FALSE :TRUE;
}

@end

@implementation SKBVButton

- (void)setHighlighted:(BOOL)highlighted{
}

@end
