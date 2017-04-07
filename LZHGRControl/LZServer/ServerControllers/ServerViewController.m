//
//  ServerViewController.m
//  LZHGRControl
//
//  Created by Jony on 17/4/1.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "ServerViewController.h"

@interface ServerViewController ()

@end

@implementation ServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"服务";
    //self.view.backgroundColor = [UIColor blackColor];
    
    EquipmentInfo *serverInfo = [[EquipmentInfoManage sharedEquipmentInfoTool] findEquipmentInfoWithName:@"服务"];
    TitleBarView *titleBarView = [[TitleBarView alloc] initWithFrame:CGRectMake(TITLEBAR_VIEW_INIT_X, TITLEBAR_VIEW_INIT_Y, TITLEBAR_VIEW_WIDTH, TITLEBAR_VIEW_HEIGHT) andEquipment:serverInfo];
    [self.view addSubview:titleBarView];
    
    ServerKeyboardView *serverKeyboardView = [[ServerKeyboardView alloc] initWithFrame:CGRectMake(SERVER_VIEW_INIT_X, SERVER_VIEW_INIT_Y, SERVER_VIEW_WIDTH, SERVER_VIEW_HEIGHT)];
    [self.view addSubview:serverKeyboardView];

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
