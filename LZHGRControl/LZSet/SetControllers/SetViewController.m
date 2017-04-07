//
//  SetViewController.m
//  LZHGRControl
//
//  Created by Jony on 17/4/1.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"设置";
    //self.view.backgroundColor = [UIColor greenColor];
    
    EquipmentInfo *setInfo = [[EquipmentInfoManage sharedEquipmentInfoTool] findEquipmentInfoWithName:@"空调"];
    TitleBarView *titleBarView = [[TitleBarView alloc] initWithFrame:CGRectMake(TITLEBAR_VIEW_INIT_X, TITLEBAR_VIEW_INIT_Y, TITLEBAR_VIEW_WIDTH, TITLEBAR_VIEW_HEIGHT) andEquipment:setInfo];
    [self.view addSubview:titleBarView];
    
    SetKeyboardView *setKeyboardView = [[SetKeyboardView alloc] initWithFrame:CGRectMake(SET_VIEW_INIT_X, SET_VIEW_INIT_Y, SET_VIEW_WIDTH, SET_VIEW_HEIGHT)];
    [self.view addSubview:setKeyboardView];
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
