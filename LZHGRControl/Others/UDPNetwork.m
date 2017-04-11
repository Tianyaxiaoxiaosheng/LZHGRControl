//
//  UDPNetwork.m
//  LZHGRControl
//
//  Created by Jony on 17/4/10.
//  Copyright © 2017年 yavatop. All rights reserved.
//

#import "UDPNetwork.h"
@interface UDPNetwork ()<AsyncUdpSocketDelegate>
@property (nonatomic, strong) NSDictionary *networkInfoDic;
@property (nonatomic, strong) DMCore *sharedDMCore;
@property (nonatomic, assign)   BOOL isReceiveNetworkData;
@property (nonatomic, strong) AsyncUdpSocket *socket;
@end

@implementation UDPNetwork

#pragma mark - lazyload
- (NSDictionary *)networkInfoDic
{
    if (!_networkInfoDic) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path = [bundle pathForResource:@"NetworkInfo" ofType:@"plist"];
        _networkInfoDic = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _networkInfoDic;
}
- (DMCore *)sharedDMCore{
    if (!_sharedDMCore) {
        _sharedDMCore = [DMCore sharedDMCore];
    }
    return _sharedDMCore;
}

#pragma mark-确保被创建一次
static UDPNetwork *sharedUDPNetwork = nil;

+ (instancetype)sharedUDPNetwork{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUDPNetwork = [super allocWithZone:zone];
    });
    return sharedUDPNetwork;
}

- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUDPNetwork = [super init];
    });
    return sharedUDPNetwork;
}

- (id)copyWithZone:(NSZone *)zone{
    return  sharedUDPNetwork;
}
+ (id)copyWithZone:(struct _NSZone *)zone{
    return  sharedUDPNetwork;
}
+ (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return sharedUDPNetwork;
}
- (id)mutableCopyWithZone:(NSZone *)zone{
    return sharedUDPNetwork;
}

#pragma mark-接收网络数据
////初始化socket通信
//- (AsyncUdpSocket *)socket{
//    if (!_socket) {
//        _socket = [[AsyncUdpSocket alloc] initIPv4];
//        _socket.delegate = self;//这步很重要，否则无法自定义监听方法
//        //绑定端口
//        NSError *error = nil;
//        [_socket bindToPort:12345 error:&error];
//        //启动接收线程
//    }
//    return _socket;
//}

- (BOOL)isIsReceiveNetworkData{
    if (!_isReceiveNetworkData) {
        _isReceiveNetworkData = FALSE;
    }
    return _isReceiveNetworkData;
}

- (BOOL)startReceiveNetworkData{
    
    if (self.isReceiveNetworkData) {
        NSLog(@"重复启动接收");
        return FALSE;
    }
    self.isReceiveNetworkData = TRUE;
    
    self.socket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    //绑定端口
    NSError *error = nil;
    [self.socket bindToPort:6000 error:&error];
    NSLog(@"%@", error);

 
    
    [self.socket sendData:[NSData dataWithBytes:@"123456789" length:9] toHost:@"172.144.1.107" port:5188 withTimeout:2.0 tag:1];

    //启动接收线程
    [self.socket receiveWithTimeout:-1 tag:0];
    return TRUE;
}

//UDP接收消息
- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port {
    NSLog(@"host----->%@ :%hu", host, port);
    //启动监听下一条消息
    [self.socket receiveWithTimeout:-1 tag:0];
    //这里可以加入你想要的代码
    return YES;
}

@end
