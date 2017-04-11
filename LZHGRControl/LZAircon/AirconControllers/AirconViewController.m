//
//  AirconViewController.m
//  LZHGRControl
//
//  Created by Jony on 17/4/1.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "AirconViewController.h"

@interface AirconViewController ()
@property (nonatomic, strong) DMCore *sharedDMCore;
@property (nonatomic, strong) TitleBarView *titleBarView;
@property (nonatomic, strong) ACNavigationView *aCNavigationView;
@property (nonatomic, strong) AirconKeyboardView *PLAirconKeyboardView;
@property (nonatomic, strong) AirconKeyboardView *BRAirconKeyboardView;

@end

@implementation AirconViewController

#pragma mark-lazyload
//纯粹为了方便
- (DMCore *)sharedDMCore{
    if (!_sharedDMCore) {
        _sharedDMCore = [DMCore sharedDMCore];
    }
    return _sharedDMCore;
}

- (TitleBarView *)titleBarView{
    if (!_titleBarView) {
        EquipmentInfo *airconInfo = [[EquipmentInfoManage sharedEquipmentInfoTool] findEquipmentInfoWithName:@"空调"];
        _titleBarView = [[TitleBarView alloc] initWithFrame:CGRectMake(TITLEBAR_VIEW_INIT_X, TITLEBAR_VIEW_INIT_Y, TITLEBAR_VIEW_WIDTH, TITLEBAR_VIEW_HEIGHT) andEquipment:airconInfo];
    }
    return _titleBarView;
}

//lazyload subView
- (AirconKeyboardView *)PLAirconKeyboardView{
    if (!_PLAirconKeyboardView) {
        _PLAirconKeyboardView = [[AirconKeyboardView alloc] initWithFrame:CGRectMake(ACKB_VIEW_INIT_X, ACKB_VIEW_INIT_Y, ACKB_VIEW_WIDTH, ACKB_VIEW_HEIGHT) andAircon:self.sharedDMCore.PLAircon];
        
        for (NSInteger i = 1; i <= 2; i++) {
            UIButton * button = [_PLAirconKeyboardView viewWithTag:i];
                        [button addTarget:self action:@selector(PLAirconKeyboardViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    return _PLAirconKeyboardView;
}

- (AirconKeyboardView *)BRAirconKeyboardView{
    if (!_BRAirconKeyboardView) {
        _BRAirconKeyboardView = [[AirconKeyboardView alloc] initWithFrame:CGRectMake(ACKB_VIEW_INIT_X, ACKB_VIEW_INIT_Y, ACKB_VIEW_WIDTH, ACKB_VIEW_HEIGHT) andAircon:self.sharedDMCore.BRAircon];
        
        for (NSInteger i = 1; i <= 2; i++) {
            UIButton * button = [_BRAirconKeyboardView viewWithTag:i];
            [button addTarget:self action:@selector(BRAirconKeyboardViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _BRAirconKeyboardView;
}

- (ACNavigationView *)aCNavigationView{
    if (!_aCNavigationView) {
        _aCNavigationView = [[ACNavigationView alloc] initWithFrame:CGRectMake(AIRCON_VIEW_INIT_X, AIRCON_VIEW_INIT_Y, AIRCON_VIEW_WIDTH, AIRCON_VIEW_HEIGHT)];
        
        [self addACNavigationViewEvents]; //并添加键盘界面导航的事件
        [self parlorACButClickEvents]; //初始化第一个键盘界面
    }
    return _aCNavigationView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加标题界面
    [self.view addSubview:self.titleBarView];
    
    //添加整个键盘导航界面
    [self.view addSubview:self.aCNavigationView];
    
    //kvo
    //因为kvo机制只能观察到set方法，而需要检测的属性都嵌套在对象中，因此注册观察者属性名称在被观察者的基础上进一步细化，不然kvo检测不到属性的变化，最终导致需要多写代码
    [self.sharedDMCore addObserver:self forKeyPath:@"PLAircon.temperature" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"PLAircon.temperature has changes"];
    [self.sharedDMCore addObserver:self forKeyPath:@"BRAircon.temperature" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"BRAircon.temperature has changes"];
}

- (void)dealloc{
    [self.sharedDMCore removeObserver:self forKeyPath:@"PLAircon.temperature"];
    [self.sharedDMCore removeObserver:self forKeyPath:@"BRAircon.temperature"];
    
}

#pragma mrak-ACNavigationView button click events
- (void)addACNavigationViewEvents{
    [self.aCNavigationView.bedroomACBut addTarget:self action:@selector(bedroomACButClickEvents) forControlEvents:UIControlEventTouchUpInside];
    [self.aCNavigationView.parlorACBut addTarget:self action:@selector(parlorACButClickEvents) forControlEvents:UIControlEventTouchUpInside];
}

- (void)bedroomACButClickEvents{
    self.aCNavigationView.bedroomACBut.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0];
    self.aCNavigationView.bedroomACBut.enabled = NO;
    self.aCNavigationView.parlorACBut.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.4];
    self.aCNavigationView.parlorACBut.enabled = YES;
    
    
    [self.PLAirconKeyboardView removeFromSuperview];
    [self.aCNavigationView addSubview:self.BRAirconKeyboardView];
    
}

- (void)parlorACButClickEvents{
    self.aCNavigationView.parlorACBut.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0];
    self.aCNavigationView.parlorACBut.enabled = NO;
    self.aCNavigationView.bedroomACBut.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.4];
    self.aCNavigationView.bedroomACBut.enabled = YES;
    
    [self.BRAirconKeyboardView removeFromSuperview];
    [self.aCNavigationView addSubview:self.PLAirconKeyboardView];
}

#pragma mrak-AirconKeyboardView button click events
- (void)PLAirconKeyboardViewButtonClicked:(UIButton *)button{
    switch (button.tag) {
        case 1:
            self.sharedDMCore.PLAircon.temperature++;
            break;
        case 2:
            self.sharedDMCore.PLAircon.temperature--;
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
            
        default:
            break;
    }

}

#pragma mrak- kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"PLAircon.temperature"]) {
        NSLog(@"%@: %@ to %@", context, [change valueForKey:@"old"], [change valueForKey:@"new"]);
        //尽量以数据中心为准，也可在此核准数据
        self.PLAirconKeyboardView.temperatureLabel.text = [NSString stringWithFormat:@"%ld", self.sharedDMCore.PLAircon.temperature];
    }else if ([keyPath isEqualToString:@"BRAircon.temperature"]){
        NSLog(@"%@: %@ to %@", context, [change valueForKey:@"old"], [change valueForKey:@"new"]);
        self.BRAirconKeyboardView.temperatureLabel.text = [NSString stringWithFormat:@"%ld", self.sharedDMCore.BRAircon.temperature];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
