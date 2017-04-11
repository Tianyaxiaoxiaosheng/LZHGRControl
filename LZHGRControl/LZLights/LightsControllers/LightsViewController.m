//
//  LightsViewController.m
//  LZHGRControl
//
//  Created by Jony on 17/4/1.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "LightsViewController.h"

@interface LightsViewController ()<LTNavigationBarViewDelegate, OverAllControlViewDelegate>
@property (nonatomic, strong) TitleBarView *titleBarView;
@property (nonatomic, strong) OverAllControlView *overAllControlView;
@property (nonatomic, strong) LTNavigationBarView *lTnavigationBarView;
@end

@implementation LightsViewController

#pragma mark - lazyload
- (TitleBarView *)titleBarView{
    if (!_titleBarView) {
        EquipmentInfo *lightInfo = [[EquipmentInfoManage sharedEquipmentInfoTool] findEquipmentInfoWithName:@"灯光"];
        _titleBarView = [[TitleBarView alloc] initWithFrame:CGRectMake(TITLEBAR_VIEW_INIT_X, TITLEBAR_VIEW_INIT_Y, TITLEBAR_VIEW_WIDTH, TITLEBAR_VIEW_HEIGHT) andEquipment:lightInfo];
    }
    return _titleBarView;
}

- (OverAllControlView *)overAllControlView{
    if (!_overAllControlView) {
        _overAllControlView = [[OverAllControlView alloc] initWithFrame:CGRectMake(OAC_VIEW_INIT_X, OAC_VIEW_INIT_Y, OAC_VIEW_WIDTH, OAC_VIEW_HEIGHT)];
        _overAllControlView.delegate = self;
    }
    return _overAllControlView;
}

- (LTNavigationBarView *)lTnavigationBarView{
    if (!_lTnavigationBarView) {
        _lTnavigationBarView = [[LTNavigationBarView alloc] initWithFrame:CGRectMake(NB_VIEW_INIT_X, NB_VIEW_INIT_Y, NB_VIEW_WIDTH, NB_VIEW_HEIGHT)];
        _lTnavigationBarView.delegate = self;
    }
    return _lTnavigationBarView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加标题界面
    [self.view addSubview:self.titleBarView];
    //添加总控界面
    [self.view addSubview:self.overAllControlView];
    //添加键盘控制界面
    [self.view addSubview:self.lTnavigationBarView];
    
}

#pragma mark - OverAllControlView delegate
-(void)OverAllSwitchONAndOFF:(NSInteger)tag{
    NSLog(@"OverAllSwitchONAndOFF: %ld", tag);
}

#pragma mark - LTNavigationBarView delegate
- (void)createdKeyboardWithLTNavigationBarView:(NSInteger)tag{
    //第一次初始化时，这边的代理方法还无法执行，除了通知，最简单的就是在这边初始化剩余的部分
    NSLog(@"createdKeyboardWithLTNavigationBarView: %ld", tag);
}

@end
