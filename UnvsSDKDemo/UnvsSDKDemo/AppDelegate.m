//
//  AppDelegate.m
//  UnvsSDKDemo
//
//  Created by jdq on 2021/10/20.
//

#import "AppDelegate.h"
#import <UnvsSDK/UnvsSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /// 开启日志
    [[UnvsManager shared] consolePrintLoggerEnable:YES];
    /// 注册AppID（UCloud号码认证平台申请）
    [[UnvsManager shared] registerWithAppId:@"ua0002"];
    /// 超时时间（单位：毫秒）
    [[UnvsManager shared] setTimeoutInterval:8000];
    return YES;
}

@end
