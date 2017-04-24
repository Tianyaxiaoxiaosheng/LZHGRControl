//
//  MainViewController.m
//  LZHGRControl
//
//  Created by Jony on 17/4/1.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<WDYTabbarDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置主界面背景
    self.view.backgroundColor = MAIN_VIEW_BACKGROUND;
    
    NSLog(@"%lf, %lf, %lf, %lf,", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
//    self.tabBar.hidden = YES; //系统的tabbar隐藏后最下面会出现白条
    
    //添加控制器
    [self addControllerForTabBarController];

}

- (void)viewDidLayoutSubviews{
//    NSLog(@"%s",__func__);
    
    //此方法在创建每个子View时都会调用，此类中调用两次，下方代码只需要一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGRect frame = CGRectMake(0
                                  , self.tabBar.frame.origin.y-41
                                  , self.tabBar.frame.size.width
                                  , 90);
        self.tabBar.frame = frame;
        
        NSLog(@"%lf, %lf, %lf, %lf,", self.tabBar.frame.origin.x, self.tabBar.frame.origin.y, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
//        self.tabBar.backgroundColor = [UIColor redColor];
        
        WDYTabbar *wDYTabbar = [[WDYTabbar alloc] initWithFrame:self.tabBar.bounds];
        
        //添加五个按钮
        [wDYTabbar addTabbarBtnWithNormalImg:@"lights0" selImg:@"lights1"];
        [wDYTabbar addTabbarBtnWithNormalImg:@"aircon0" selImg:@"aircon1"];
        [wDYTabbar addTabbarBtnWithNormalImg:@"service0" selImg:@"service1"];
        [wDYTabbar addTabbarBtnWithNormalImg:@"setting0" selImg:@"setting1"];
        
        //设置代理
        wDYTabbar.delegate = self;
        
        //把自定义的tabbar添加到 系统的tabbar上
        [self.tabBar addSubview:wDYTabbar];
    });
 
 
}

//添加控制器
- (void)addControllerForTabBarController{
    //创建控制器
//    EquipmentInfoManage *sharedEquipmentInfoTool = [EquipmentInfoManage sharedEquipmentInfoTool];
    //灯光控制器
//    EquipmentInfo *lightInfo = [sharedEquipmentInfoTool findEquipmentInfoWithName:@"灯光"];
    LightsViewController *lightsViewController = [[LightsViewController alloc] init];
    //    lightsViewController.tabBarItem.title = lightInfo.title;
    //    lightsViewController.tabBarItem.image = [UIImage imageNamed:@"灯光01"];
    
    //空调控制器
//    EquipmentInfo *airconInfo = [sharedEquipmentInfoTool findEquipmentInfoWithName:@"空调"];
    AirconViewController *airconViewController = [[AirconViewController alloc] init];
    //    airconViewController.tabBarItem.title = airconInfo.title;
    //    airconViewController.tabBarItem.image = [UIImage imageNamed:@"空调01"];
    
    //服务控制器
//    EquipmentInfo *serverInfo = [sharedEquipmentInfoTool findEquipmentInfoWithName:@"服务"];
    ServerViewController *serverViewController = [[ServerViewController alloc] init];
    //    serverViewController.tabBarItem.title = serverInfo.title;
    //    serverViewController.tabBarItem.image = [UIImage imageNamed:@"服务01"];
    
    //设置控制器
//    EquipmentInfo *setInfo = [sharedEquipmentInfoTool findEquipmentInfoWithName:@"设置"];
    SetViewController *setViewController = [[SetViewController alloc] init];
    //    setViewController.tabBarItem.title = setInfo.title;
    //    setViewController.tabBarItem.image = [UIImage imageNamed:@"设置01"];
    
    //添加控制器
    self.viewControllers = @[lightsViewController, airconViewController, serverViewController, setViewController];
}

#pragma mark 自定义Tabbar的代理
-(void)tabbar:(WDYTabbar *)tabbar didSelectedFrom:(NSInteger)from to:(NSInteger)to{
    //切换tabbar控制器的子控件器
    self.selectedIndex = to;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
