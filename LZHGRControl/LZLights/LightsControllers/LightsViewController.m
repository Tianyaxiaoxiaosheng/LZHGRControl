//
//  LightsViewController.m
//  LZHGRControl
//
//  Created by Jony on 17/4/1.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "LightsViewController.h"

@interface LightsViewController ()<LTNavigationBarViewDelegate, OverAllControlViewDelegate>

@end

@implementation LightsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.title = @"灯光";
    //self.view.backgroundColor = [UIColor redColor];

    
    //Test TitleBarView
    EquipmentInfo *lightInfo = [[EquipmentInfoManage sharedEquipmentInfoTool] findEquipmentInfoWithName:@"灯光"];
    TitleBarView *titleBarView = [[TitleBarView alloc] initWithFrame:CGRectMake(TITLEBAR_VIEW_INIT_X, TITLEBAR_VIEW_INIT_Y, TITLEBAR_VIEW_WIDTH, TITLEBAR_VIEW_HEIGHT) andEquipment:lightInfo];
    [self.view addSubview:titleBarView];
    
    
   
    OverAllControlView *overAllControlView = [[OverAllControlView alloc] initWithFrame:CGRectMake(OAC_VIEW_INIT_X, OAC_VIEW_INIT_Y, OAC_VIEW_WIDTH, OAC_VIEW_HEIGHT)];
    overAllControlView.delegate = self;
    [self.view addSubview:overAllControlView];
    
    LTNavigationBarView *lTnavigationBarView = [[LTNavigationBarView alloc] initWithFrame:CGRectMake(NB_VIEW_INIT_X, NB_VIEW_INIT_Y, NB_VIEW_WIDTH, NB_VIEW_HEIGHT)];
    lTnavigationBarView.delegate = self;
    [self.view addSubview:lTnavigationBarView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate

-(void)OverAllSwitchONAndOFF:(NSInteger)tag{
    NSLog(@"OverAllSwitchONAndOFF: %ld", tag);
}

- (void)createdKeyboardWithLTNavigationBarView:(NSInteger)tag{
    NSLog(@"createdKeyboardWithLTNavigationBarView: %ld", tag);
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
