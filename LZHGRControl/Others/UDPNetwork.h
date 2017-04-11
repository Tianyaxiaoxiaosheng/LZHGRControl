//
//  UDPNetwork.h
//  LZHGRControl
//
//  Created by Jony on 17/4/10.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UDPNetwork : NSObject

+ (instancetype)sharedUDPNetwork;

- (BOOL)startReceiveNetworkData;
@end
