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

@property (nonatomic, strong) TitleBarView        *titleBarView;
@property (nonatomic, strong) OverAllControlView  *overAllControlView;
@property (nonatomic, strong) LTNavigationBarView *lTnavigationBarView;

//子键盘界面
@property (nonatomic, strong) BedroomLTView       *bedroomLTView;
@property (nonatomic, strong) MainLampLTView      *mainLampLTView;
@property (nonatomic, strong) ToletLTView         *toletLTView;
@property (nonatomic, strong) CloakroomLTView     *cloakroomLTView;
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

//各个子键盘
- (BedroomLTView *)bedroomLTView{
    if (!_bedroomLTView) {
        _bedroomLTView = [[BedroomLTView alloc] initWithFrame:CGRectMake(LKB_VIEW_INIT_X, LKB_VIEW_INIT_Y, LKB_VIEW_WIDTH, LKB_VIEW_HEIGHT) andBedroomm:self.sharedDMCore.bedroom];
    }
    return _bedroomLTView;
}
- (MainLampLTView *)mainLampLTView{
    if (!_mainLampLTView) {
        _mainLampLTView= [[MainLampLTView alloc] initWithFrame:CGRectMake(LKB_VIEW_INIT_X, LKB_VIEW_INIT_Y, LKB_VIEW_WIDTH, LKB_VIEW_HEIGHT) andMainLamp:self.sharedDMCore.mainLamp];
    }
    return _mainLampLTView;
}
- (ToletLTView *)toletLTView{
    if (!_toletLTView) {
        _toletLTView = [[ToletLTView alloc] initWithFrame:CGRectMake(LKB_VIEW_INIT_X, LKB_VIEW_INIT_Y, LKB_VIEW_WIDTH, LKB_VIEW_HEIGHT) andTolet:self.sharedDMCore.tolet];
    }
    return _toletLTView;
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
    
    //初始化键盘控制界面
    [self initLTnavigationBarKeyboardView];
    //kvo
    [self addObserverForLightsProperty];
    
}

- (void)initLTnavigationBarKeyboardView{
    
    [self.lTnavigationBarView addSubview:self.bedroomLTView];
    self.tempView = self.bedroomLTView;
}
     
- (void)addObserverForLightsProperty{
    
    //卧室
    [self.sharedDMCore addObserver:self forKeyPath:@"bedroom.lBedLamp" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"bedroom.lBedLamp has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"bedroom.rBedLamp" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"bedroom.rBedLamp has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"bedroom.lReadingLamp" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"bedroom.lReadingLamp has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"bedroom.rReadingLamp" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"bedroom.rReadingLamp has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"bedroom.roomLamp" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"bedroom.roomLamp has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"bedroom.romantic" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"bedroom.romantic has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"bedroom.sleep" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"bedroom.sleep has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"bedroom.working" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"bedroom.working has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"bedroom.reception" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"bedroom.reception has changes"];
 
    //客厅
    [self.sharedDMCore addObserver:self forKeyPath:@"mainLamp.roomLamp" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"mainLamp.roomLamp has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"mainLamp.corridor" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"mainLamp.corridor has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"mainLamp.working" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"mainLamp.working has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"mainLamp.reception" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"mainLamp.reception has changes"];
    
    //卫生间
    [self.sharedDMCore addObserver:self forKeyPath:@"tolet.wallLamp" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"tolet.wallLamp has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"tolet.sPA" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"tolet.sPA has changes"];
    
    //衣帽间
    [self.sharedDMCore addObserver:self forKeyPath:@"cloakroom.topLamp" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"cloakroom.topLamp has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"cloakroom.lightStrip" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"cloakroom.lightStrip has changes"];

    //客卫
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
        case 1:
            [self replaceLTnavigationBarViewKeyboardView:self.bedroomLTView];
            break;
        case 2:
            [self replaceLTnavigationBarViewKeyboardView:self.mainLampLTView];
            break;
        case 3:
            [self replaceLTnavigationBarViewKeyboardView:self.toletLTView];
            break;
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
    //卧室
    if ([keyPath isEqualToString:@"bedroom.lBedLamp"]) {
        UIButton *button = [self.bedroomLTView viewWithTag:1];
        button.selected = self.sharedDMCore.bedroom.lBedLamp;
    }else if ([keyPath isEqualToString:@"bedroom.rBedLamp"]){
        UIButton *button = [self.bedroomLTView viewWithTag:2];
        button.selected = self.sharedDMCore.bedroom.rBedLamp;
    }else if ([keyPath isEqualToString:@"bedroom.lReadingLamp"]){
        UIButton *button = [self.bedroomLTView viewWithTag:3];
        button.selected = self.sharedDMCore.bedroom.lReadingLamp;
    }else if ([keyPath isEqualToString:@"bedroom.rReadingLamp"]){
        UIButton *button = [self.bedroomLTView viewWithTag:4];
        button.selected = self.sharedDMCore.bedroom.rReadingLamp;
    }else if ([keyPath isEqualToString:@"bedroom.roomLamp"]){
        UIButton *button = [self.bedroomLTView viewWithTag:5];
        button.selected = self.sharedDMCore.bedroom.roomLamp;
    }else if ([keyPath isEqualToString:@"bedroom.romantic"]){
        UIButton *button = [self.bedroomLTView viewWithTag:6];
        button.selected = self.sharedDMCore.bedroom.romantic;
    }else if ([keyPath isEqualToString:@"bedroom.sleep"]){
        UIButton *button = [self.bedroomLTView viewWithTag:7];
        button.selected = self.sharedDMCore.bedroom.sleep;
    }else if ([keyPath isEqualToString:@"bedroom.working"]){
        UIButton *button = [self.bedroomLTView viewWithTag:8];
        button.selected = self.sharedDMCore.bedroom.working;
    }else if ([keyPath isEqualToString:@"bedroom.reception"]){
        UIButton *button = [self.bedroomLTView viewWithTag:9];
        button.selected = self.sharedDMCore.bedroom.reception;
    }
    
    //客厅
    else if ([keyPath isEqualToString:@"mainLamp.roomLamp"]){
        UIButton *button = [self.mainLampLTView viewWithTag:1];
        button.selected = self.sharedDMCore.mainLamp.roomLamp;
    }else if ([keyPath isEqualToString:@"mainLamp.corridor"]){
        UIButton *button = [self.mainLampLTView viewWithTag:2];
        button.selected = self.sharedDMCore.mainLamp.corridor;
    }else if ([keyPath isEqualToString:@"mainLamp.working"]){
        UIButton *button = [self.mainLampLTView viewWithTag:3];
        button.selected = self.sharedDMCore.mainLamp.working;
    }else if ([keyPath isEqualToString:@"mainLamp.reception"]){
        UIButton *button = [self.mainLampLTView viewWithTag:4];
        button.selected = self.sharedDMCore.mainLamp.reception;
    }


    //卫生间
    else if ([keyPath isEqualToString:@"tolet.wallLamp"]){
        UIButton *button = [self.toletLTView viewWithTag:3];
        button.selected = self.sharedDMCore.tolet.wallLamp;
    }else if ([keyPath isEqualToString:@"tolet.sPA"]){
        UIButton *button = [self.toletLTView viewWithTag:4];
        button.selected = self.sharedDMCore.tolet.sPA;
    }

     //衣帽间
    else if ([keyPath isEqualToString:@"cloakroom.topLamp"]) {
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
