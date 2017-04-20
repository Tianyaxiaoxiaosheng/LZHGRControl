//
//  MainViewController.m
//  LZHGRControl
//
//  Created by Jony on 17/4/1.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置主界面背景
    self.view.backgroundColor = MAIN_VIEW_BACKGROUND;
    
    //更改默认高度
    
    
    //创建控制器
    EquipmentInfoManage *sharedEquipmentInfoTool = [EquipmentInfoManage sharedEquipmentInfoTool];
    //灯光控制器
    EquipmentInfo *lightInfo = [sharedEquipmentInfoTool findEquipmentInfoWithName:@"灯光"];
    LightsViewController *lightsViewController = [[LightsViewController alloc] init];
    lightsViewController.tabBarItem.title = lightInfo.title;
    lightsViewController.tabBarItem.image = [UIImage imageNamed:@"灯光01"];
    
    //空调控制器
    EquipmentInfo *airconInfo = [sharedEquipmentInfoTool findEquipmentInfoWithName:@"空调"];
    AirconViewController *airconViewController = [[AirconViewController alloc] init];
    airconViewController.tabBarItem.title = airconInfo.title;
    airconViewController.tabBarItem.image = [UIImage imageNamed:@"空调01"];
    
    //服务控制器
    EquipmentInfo *serverInfo = [sharedEquipmentInfoTool findEquipmentInfoWithName:@"服务"];
    ServerViewController *serverViewController = [[ServerViewController alloc] init];
    serverViewController.tabBarItem.title = serverInfo.title;
    serverViewController.tabBarItem.image = [UIImage imageNamed:@"服务01"];
    
    //设置控制器
    EquipmentInfo *setInfo = [sharedEquipmentInfoTool findEquipmentInfoWithName:@"设置"];
    SetViewController *setViewController = [[SetViewController alloc] init];
    setViewController.tabBarItem.title = setInfo.title;
    setViewController.tabBarItem.image = [UIImage imageNamed:@"设置01"];
    
    //添加控制器
    self.viewControllers = @[lightsViewController, airconViewController, serverViewController, setViewController];
  
    //设置分栏
//    UITabBar *tabBar = self.tabBar;
//    tabBar.frame.size.height = 100.0;
//    tabBar.barStyle = UIBarStyleBlack;
//    tabBar.translucent = NO;
//    tabBar.barTintColor = [UIColor redColor];
//    tabBar.backgroundColor = [UIColor orangeColor];
    

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
