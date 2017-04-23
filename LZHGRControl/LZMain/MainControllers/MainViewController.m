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
    self.tabBar.backgroundColor = [UIColor colorWithRed:192/255 green:192/255 blue:192/255 alpha:0.0];
    
    //替换系统Tarbar
    CGRect tabbarFrame = CGRectMake(self.tabBar.bounds.origin.x
                               , self.view.bounds.size.height-90
                               , self.tabBar.bounds.size.width
                               , 90);
    WDYTabbar *wDYTabbar = [[WDYTabbar alloc] initWithFrame:tabbarFrame];
    
    [wDYTabbar addTabbarBtnWithNormalImg:@"lights0" selImg:@"lights1"];
    [wDYTabbar addTabbarBtnWithNormalImg:@"aircon0" selImg:@"aircon1"];
    [wDYTabbar addTabbarBtnWithNormalImg:@"service0" selImg:@"service1"];
    [wDYTabbar addTabbarBtnWithNormalImg:@"setting0" selImg:@"setting1"];
    
    //设置代理
    wDYTabbar.delegate = self;
    
    //把自定义的tabbar添加到 系统的tabbar上
//    self.tabBar.frame.size.height = self.tabBar.frame.size.height+1100;
    [self.view addSubview:wDYTabbar];
    
    //添加控制器
    [self addControllerForTabBarController];
    
  
    //设置分栏
//    UITabBar *tabBar = self.tabBar;
//    tabBar.frame.size.height = 100.0;
//    tabBar.barStyle = UIBarStyleBlack;
//    tabBar.translucent = NO;
//    tabBar.barTintColor = [UIColor redColor];
//    tabBar.backgroundColor = [UIColor orangeColor];
    

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
