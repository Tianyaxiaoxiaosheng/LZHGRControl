//
//  AirconKeyboardView.h
//  LZHGRControl
//
//  Created by Jony on 17/4/7.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirconKeyboardView : UIView
@property (nonatomic, strong) Aircon *parlorAC;
@property (nonatomic, strong) Aircon *bedroomAC;

-(instancetype)initWithFrame:(CGRect)frame andParlorAC:(Aircon *)parlorAC BedroomAC:(Aircon *)bedroomAC;
@end
