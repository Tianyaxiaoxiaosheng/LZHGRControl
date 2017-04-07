//
//  EquipmentInfo.h
//  LZHGRControl
//
//  Created by Jony on 17/2/17.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EquipmentInfo : NSObject

@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *icon;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)equipmentInfoWithDic:(NSDictionary *)dic;

+ (NSArray *)equipmentInfoList;


@end
