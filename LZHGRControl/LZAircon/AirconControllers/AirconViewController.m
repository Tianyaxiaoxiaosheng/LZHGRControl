//
//  AirconViewController.m
//  LZHGRControl
//
//  Created by Jony on 17/4/1.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "AirconViewController.h"

@interface AirconViewController ()

@end

@implementation AirconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"空调";
    //self.view.backgroundColor = [UIColor blueColor];
    
    EquipmentInfo *airconInfo = [[EquipmentInfoManage sharedEquipmentInfoTool] findEquipmentInfoWithName:@"空调"];
    TitleBarView *titleBarView = [[TitleBarView alloc] initWithFrame:CGRectMake(TITLEBAR_VIEW_INIT_X, TITLEBAR_VIEW_INIT_Y, TITLEBAR_VIEW_WIDTH, TITLEBAR_VIEW_HEIGHT) andEquipment:airconInfo];
    [self.view addSubview:titleBarView];
    
    
    Aircon *parlorAC = [[Aircon alloc] init];
    parlorAC.temperature = 5;
    Aircon *bedroomAC = [[Aircon alloc] init];
    bedroomAC.temperature = 9;
    AirconKeyboardView *airconKeyboardView = [[AirconKeyboardView alloc] initWithFrame:CGRectMake(AIRCON_VIEW_INIT_X, AIRCON_VIEW_INIT_Y, AIRCON_VIEW_WIDTH, AIRCON_VIEW_HEIGHT) andParlorAC:parlorAC BedroomAC:bedroomAC];
    [self.view addSubview:airconKeyboardView];


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
