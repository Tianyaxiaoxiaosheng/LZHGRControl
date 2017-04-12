//
//  LightsViewController.m
//  LZHGRControl
//
//  Created by Jony on 17/4/1.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "LightsViewController.h"

@interface LightsViewController ()<LTNavigationBarViewDelegate, OverAllControlViewDelegate>
//数据
@property (nonatomic, strong) DMCore *sharedDMCore;
//临时uiview
@property (nonatomic, strong) id tempView;

@property (nonatomic, strong) TitleBarView *titleBarView;
@property (nonatomic, strong) OverAllControlView *overAllControlView;
@property (nonatomic, strong) LTNavigationBarView *lTnavigationBarView;

//子键盘界面
@property (nonatomic, strong) CloakroomLTView *cloakroomLTView;
@property (nonatomic, strong) GuestBathroomLTView *guestBathroomLTView;

@end

@implementation LightsViewController

#pragma mark - lazyload ////////////////////////////////////////////////////////////
- (DMCore *)sharedDMCore{
    if (!_sharedDMCore) {
        _sharedDMCore = [DMCore sharedDMCore];
    }
    return _sharedDMCore;
}


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

- (CloakroomLTView *)cloakroomLTView{
    if (!_cloakroomLTView) {
        _cloakroomLTView = [[CloakroomLTView alloc] initWithFrame:CGRectMake(LKB_VIEW_INIT_X, LKB_VIEW_INIT_Y, LKB_VIEW_WIDTH, LKB_VIEW_HEIGHT) andCloakroom:self.sharedDMCore.cloakroom];
    }
    return _cloakroomLTView;
}
- (GuestBathroomLTView *)guestBathroomLTView{
    if (!_guestBathroomLTView) {
        _guestBathroomLTView = [[GuestBathroomLTView alloc] initWithFrame:CGRectMake(LKB_VIEW_INIT_X, LKB_VIEW_INIT_Y, LKB_VIEW_WIDTH, LKB_VIEW_HEIGHT) andGuestBathroom:self.sharedDMCore.guestBathroom];
    }
    return _guestBathroomLTView;
}

/////////////////////////////////////跟视图加载////////////////////////////////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加标题界面
    [self.view addSubview:self.titleBarView];
    //添加总控界面
    [self.view addSubview:self.overAllControlView];
    //添加键盘控制界面
    [self.view addSubview:self.lTnavigationBarView];
    
    //kvo
    [self addObserverForLightsProperty];
    
}
     
- (void)addObserverForLightsProperty{
    
    //卧室
    //客厅
    //卫生间
     
    //衣帽间
//    sharedDMCore.cloakroom.topLamp = isOpen;
//    sharedDMCore.cloakroom.lightStrip = isOpen;
    [self.sharedDMCore addObserver:self forKeyPath:@"cloakroom.topLamp" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"cloakroom.topLamp has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"cloakroom.lightStrip" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"cloakroom.lightStrip has changes"];

    //客卫
//    sharedDMCore.guestBathroom.topLamp = isOpen;
//    sharedDMCore.guestBathroom.lightStrip = isOpen;
//    sharedDMCore.guestBathroom.wallLamp = isOpen;
    [self.sharedDMCore addObserver:self forKeyPath:@"guestBathroom.topLamp" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"guestBathroom.topLamp has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"guestBathroom.lightStrip" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"guestBathroom.lightStrip has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"guestBathroom.wallLamp" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"guestBathroom.wallLamp has changes"];
}


#pragma mark - OverAllControlView delegate /////////////////////////////////////////////////////
-(void)OverAllSwitchONAndOFF:(NSInteger)tag{
//    NSLog(@"OverAllSwitchONAndOFF: %ld", tag);
    switch (tag) {
        case 1:
            [self.tempView allLightsSwitchIsOpen:TRUE];
            break;
        case 2:
            [self.tempView allLightsSwitchIsOpen:FALSE];
            break;
            
        default:
            break;
    }
}

#pragma mark - LTNavigationBarView delegate ///////////////////////////////////////////////////
- (void)createdKeyboardWithLTNavigationBarView:(NSInteger)tag{
    //第一次初始化时，这边的代理方法还无法执行，除了通知，最简单的就是在这边初始化剩余的部分
//    NSLog(@"createdKeyboardWithLTNavigationBarView: %ld", tag);
//    [self.lTnavigationBarView addSubview:self.cloakroomLTView];
    switch (tag) {
        case 4:
            [self replaceLTnavigationBarViewKeyboardView:self.cloakroomLTView];
            break;
        case 5:
            [self replaceLTnavigationBarViewKeyboardView:self.guestBathroomLTView];
            break;
            
        default:
            break;
    }
}
//替换界面
- (void)replaceLTnavigationBarViewKeyboardView:(UIView *)view{
    [self.tempView removeFromSuperview];
    self.tempView = view;
    [self.lTnavigationBarView addSubview:view];
}

#pragma mark - kvo //////////////////////////////////////////////////////////////////////
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    NSLog(@"%@: %@ to %@", context, [change valueForKey:@"old"], [change valueForKey:@"new"]);
    
     //衣帽间
    if ([keyPath isEqualToString:@"cloakroom.topLamp"]) {
        UIButton *button = [self.cloakroomLTView viewWithTag:1];
        button.selected = self.sharedDMCore.cloakroom.topLamp;
    }else if ([keyPath isEqualToString:@"cloakroom.lightStrip"]){
        UIButton *button = [self.cloakroomLTView viewWithTag:2];
        button.selected = self.sharedDMCore.cloakroom.lightStrip;
    }
    
    //客卫
    else if ([keyPath isEqualToString:@"guestBathroom.topLamp"]){
        UIButton *button = [self.guestBathroomLTView viewWithTag:1];
        button.selected = self.sharedDMCore.guestBathroom.topLamp;
    }else if ([keyPath isEqualToString:@"guestBathroom.lightStrip"]){
        UIButton *button = [self.guestBathroomLTView viewWithTag:2];
        button.selected = self.sharedDMCore.guestBathroom.lightStrip;
    }else if ([keyPath isEqualToString:@"guestBathroom.wallLamp"]){
        UIButton *button = [self.guestBathroomLTView viewWithTag:3];
        button.selected = self.sharedDMCore.guestBathroom.wallLamp;
    }


}

@end
