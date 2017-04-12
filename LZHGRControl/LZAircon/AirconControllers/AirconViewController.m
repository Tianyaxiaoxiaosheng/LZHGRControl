//
//  AirconViewController.m
//  LZHGRControl
//
//  Created by Jony on 17/4/1.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "AirconViewController.h"

@interface AirconViewController ()
@property (nonatomic, strong) DMCore *sharedDMCore;                  //数据共享类
@property (nonatomic, strong) TitleBarView *titleBarView;            //标题视图
@property (nonatomic, strong) ACNavigationView *aCNavigationView;    //键盘导航视图（包括键盘显示区域）
@property (nonatomic, strong) AirconKeyboardView *PLAirconKeyboardView; //客厅空调键盘视图
@property (nonatomic, strong) AirconKeyboardView *BRAirconKeyboardView;  //卧室空调键盘视图

//空调模式显示的数组
@property (nonatomic, strong) NSArray *modeTypeImages;
@property (nonatomic, strong) NSArray *windTypeImages;
@end

@implementation AirconViewController
///////////////////////////////////////////////////////////////////////////
#pragma mark-lazyload
//加载空调模式显示的数组
- (NSArray *)modeTypeImages{
    if (!_modeTypeImages) {
        _modeTypeImages = @[@"model_hot", @"model_code", @"model_wind"];
    }
    return _modeTypeImages;
}
- (NSArray *)windTypeImages{
    if (!_windTypeImages) {
        _windTypeImages = @[@"wind_speed0", @"wind_speed1", @"wind_speed2", @"wind_speed3", @"wind_speed4"];
    }
    return _windTypeImages;
}

//纯粹为了方便
- (DMCore *)sharedDMCore{
    if (!_sharedDMCore) {
        _sharedDMCore = [DMCore sharedDMCore];
    }
    return _sharedDMCore;
}
//懒加载标题视图
- (TitleBarView *)titleBarView{
    if (!_titleBarView) {
        EquipmentInfo *airconInfo = [[EquipmentInfoManage sharedEquipmentInfoTool] findEquipmentInfoWithName:@"空调"];
        _titleBarView = [[TitleBarView alloc] initWithFrame:CGRectMake(TITLEBAR_VIEW_INIT_X, TITLEBAR_VIEW_INIT_Y, TITLEBAR_VIEW_WIDTH, TITLEBAR_VIEW_HEIGHT) andEquipment:airconInfo];
    }
    return _titleBarView;
}

//懒加载客厅空调键盘
- (AirconKeyboardView *)PLAirconKeyboardView{
    if (!_PLAirconKeyboardView) {
        _PLAirconKeyboardView = [[AirconKeyboardView alloc] initWithFrame:CGRectMake(ACKB_VIEW_INIT_X, ACKB_VIEW_INIT_Y, ACKB_VIEW_WIDTH, ACKB_VIEW_HEIGHT) andAircon:self.sharedDMCore.PLAircon];
        
        for (NSInteger i = 1; i <= 11; i++) {
            UIButton * button = [_PLAirconKeyboardView viewWithTag:i];
                        [button addTarget:self action:@selector(PLAirconKeyboardViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    return _PLAirconKeyboardView;
}
//懒加载卧室空调键盘
- (AirconKeyboardView *)BRAirconKeyboardView{
    if (!_BRAirconKeyboardView) {
        _BRAirconKeyboardView = [[AirconKeyboardView alloc] initWithFrame:CGRectMake(ACKB_VIEW_INIT_X, ACKB_VIEW_INIT_Y, ACKB_VIEW_WIDTH, ACKB_VIEW_HEIGHT) andAircon:self.sharedDMCore.BRAircon];
        
        for (NSInteger i = 1; i <= 11; i++) {
            UIButton * button = [_BRAirconKeyboardView viewWithTag:i];
            [button addTarget:self action:@selector(BRAirconKeyboardViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _BRAirconKeyboardView;
}
//懒加载导航视图
- (ACNavigationView *)aCNavigationView{
    if (!_aCNavigationView) {
        _aCNavigationView = [[ACNavigationView alloc] initWithFrame:CGRectMake(AIRCON_VIEW_INIT_X, AIRCON_VIEW_INIT_Y, AIRCON_VIEW_WIDTH, AIRCON_VIEW_HEIGHT)];
        
        [self addACNavigationViewEvents]; //并添加键盘界面导航的事件
        [self parlorACButClickEvents]; //初始化第一个键盘界面
    }
    return _aCNavigationView;
}


////////////////////////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加标题界面
    [self.view addSubview:self.titleBarView];
    
    //添加整个键盘导航界面
    [self.view addSubview:self.aCNavigationView];
    
    //kvo
    [self addObserverForAirconProperty];
 
}

//控制器挂掉时移除观察者
- (void)dealloc{
    [self.sharedDMCore removeObserver:self forKeyPath:@"PLAircon.temperature"];
    [self.sharedDMCore removeObserver:self forKeyPath:@"BRAircon.temperature"];
    
}


/**
 *添加观察者
 *分别为需要观察的属性添加观察者
 *注：因为kvo机制只能观察到set方法，而需要检测的属性都嵌套在对象中，因此注册观察者属性名称在被观察者的基础上进一步细化，
 *不然kvo检测不到属性的变化，最终导致需要多写代码
 */
- (void)addObserverForAirconProperty{
    
    //温度
    [self.sharedDMCore addObserver:self forKeyPath:@"PLAircon.temperature" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"PLAircon.temperature has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"BRAircon.temperature" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"BRAircon.temperature has changes"];
    
    //模式
    [self.sharedDMCore addObserver:self forKeyPath:@"PLAircon.modelType" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"PLAircon.modelType has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"BRAircon.modelType" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"BRAircon.modelType has changes"];
    //风模式
    [self.sharedDMCore addObserver:self forKeyPath:@"PLAircon.windType" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"PLAircon.windType has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"BRAircon.windType" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"BRAircon.windType has changes"];
}

#pragma mrak-ACNavigationView button click events ////////////////////////////////////
//导航条添加事件并实现
- (void)addACNavigationViewEvents{
    [self.aCNavigationView.bedroomACBut addTarget:self action:@selector(bedroomACButClickEvents) forControlEvents:UIControlEventTouchUpInside];
    [self.aCNavigationView.parlorACBut addTarget:self action:@selector(parlorACButClickEvents) forControlEvents:UIControlEventTouchUpInside];
}

- (void)bedroomACButClickEvents{
    self.aCNavigationView.bedroomACBut.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0];
    self.aCNavigationView.bedroomACBut.enabled = NO;
    self.aCNavigationView.parlorACBut.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.2];
    self.aCNavigationView.parlorACBut.enabled = YES;
    
    
    [self.PLAirconKeyboardView removeFromSuperview];
    [self.aCNavigationView addSubview:self.BRAirconKeyboardView];
    
}

- (void)parlorACButClickEvents{
    self.aCNavigationView.parlorACBut.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0];
    self.aCNavigationView.parlorACBut.enabled = NO;
    self.aCNavigationView.bedroomACBut.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.2];
    self.aCNavigationView.bedroomACBut.enabled = YES;
    
    [self.BRAirconKeyboardView removeFromSuperview];
    [self.aCNavigationView addSubview:self.PLAirconKeyboardView];
}

#pragma mrak-AirconKeyboardView button click events  /////////////////////////////////////////////
//键盘按钮事件实现
- (void)PLAirconKeyboardViewButtonClicked:(UIButton *)button{
    switch (button.tag) {
        case 1:
            self.sharedDMCore.PLAircon.temperature++;
            break;
        case 2:
            self.sharedDMCore.PLAircon.temperature--;
            break;
        case 3:
        case 4:
        case 5:
            self.sharedDMCore.PLAircon.modelType = button.tag%3;
            break;
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
            self.sharedDMCore.PLAircon.windType = button.tag%6;
            break;
            
        default:
            break;
    }
}

- (void)BRAirconKeyboardViewButtonClicked:(UIButton *)button{
    switch (button.tag) {
        case 1:
            self.sharedDMCore.BRAircon.temperature++;
            break;
        case 2:
            self.sharedDMCore.BRAircon.temperature--;
            break;
        case 3:
        case 4:
        case 5:
            self.sharedDMCore.BRAircon.modelType = button.tag%3;
            break;
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
            self.sharedDMCore.BRAircon.windType = button.tag%6;
            break;

            
        default:
            break;
    }

}

#pragma mrak- kvo //////////////////////////////////////////////////////////////////////////
/**
 *KVO接收通知并处理，更新视图
 *根据keyPath的值进行分类处理
 *change新旧值得字典
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    //温度变化处理
    if ([keyPath isEqualToString:@"PLAircon.temperature"]) {
        //NSLog(@"%@: %@ to %@", context, [change valueForKey:@"old"], [change valueForKey:@"new"]);
        //尽量以数据中心为准，也可在此核准数据
        self.PLAirconKeyboardView.temperatureLabel.text = [NSString stringWithFormat:@"%ld", self.sharedDMCore.PLAircon.temperature];
    }else if ([keyPath isEqualToString:@"BRAircon.temperature"]){
//        NSLog(@"%@: %@ to %@", context, [change valueForKey:@"old"], [change valueForKey:@"new"]);
        self.BRAirconKeyboardView.temperatureLabel.text = [NSString stringWithFormat:@"%ld", self.sharedDMCore.BRAircon.temperature];
    }
    
    //模式变化处理
    else if ([keyPath isEqualToString:@"PLAircon.modelType"]){
        //NSLog(@"%@: %@ to %@", context, [change valueForKey:@"old"], [change valueForKey:@"new"]);
        self.PLAirconKeyboardView.modeTypeImage.image = [UIImage imageNamed:self.modeTypeImages[self.sharedDMCore.PLAircon.modelType]];
    }else if ([keyPath isEqualToString:@"BRAircon.modelType"]){
        //NSLog(@"%@: %@ to %@", context, [change valueForKey:@"old"], [change valueForKey:@"new"]);
        self.BRAirconKeyboardView.modeTypeImage.image = [UIImage imageNamed:self.modeTypeImages[self.sharedDMCore.BRAircon.modelType]];
    }
    
    //风模式变化处理
    else if ([keyPath isEqualToString:@"PLAircon.windType"]){
        //NSLog(@"%@: %@ to %@", context, [change valueForKey:@"old"], [change valueForKey:@"new"]);
        self.PLAirconKeyboardView.windTypeImage.image = [UIImage imageNamed:self.windTypeImages[self.sharedDMCore.PLAircon.windType]];
    }else if ([keyPath isEqualToString:@"BRAircon.windType"]){
        //NSLog(@"%@: %@ to %@", context, [change valueForKey:@"old"], [change valueForKey:@"new"]);
       self.BRAirconKeyboardView.windTypeImage.image = [UIImage imageNamed:self.windTypeImages[self.sharedDMCore.BRAircon.windType]];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
