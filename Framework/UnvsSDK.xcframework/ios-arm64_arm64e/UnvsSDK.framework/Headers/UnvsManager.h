//
//  UnvsManager.h
//  UnvsSDK
//
//  Created by jdq on 2021/10/18.
//

#import <Foundation/Foundation.h>
#import <UnvsSDK/UEnums.h>

NS_ASSUME_NONNULL_BEGIN

@class UAuthViewConfig;

@interface UnvsManager : NSObject

/**
 *  @abstract 授权页拉起成功回调
 */
@property (nonatomic, copy) void(^authPageCompleteBlock)(void);

/**
 *  @abstract 单例
 *
 *  @return 返回UnvsManager对象
 */
+ (UnvsManager *)shared;

/**
 *  @abstract 初始化配置
 *
 *  @param appId UCloud号码认证平台分配的ID
 */
- (void)registerWithAppId:(NSString *)appId;

/**
 *  @abstract 一键登录预取号，提前调用可加速一键登录授权页唤起
 */
- (void)preLoadLoginAuthorizePageWithCompletion:(void(^)(NSError * _Nullable))completion;

/**
 *  @abstract 一键登录授权页
 *  @param viewConfig View配置
 *  @param completion 回调，error 错误信息，取号token
 */
- (void)loadLoginAuthorizePageWithViewConfig:(UAuthViewConfig *)viewConfig completion:(void (^)(NSError *error, NSString *token))completion;

/**
 *  @abstract 关闭授权页
 *  @param completion 回调
 */
- (void)unloadLoginAuthorizePageAnimated:(BOOL)animated completion:(void (^_Nullable)(void))completion;

/**
 *  @abstract 手机号码检测，获取token
 */
- (void)verifyPhoneNumberCompletion:(void(^)(NSError * _Nullable, NSString * _Nullable))completion;

/**
 *  @abstract 日志打印
 *  @param enable 是否开启
 */
- (void)consolePrintLoggerEnable:(BOOL)enable;

/**
 *  @abstract 超时设置
 *  @param interval 请求超时时间
 */
- (void)setTimeoutInterval:(NSTimeInterval)interval;

/**
 *  @abstract 运营商类型
 *  查看 UCarrierType 枚举
 */
- (UCarrierType)carrierType;

/**
 *  @abstract 连接网络类型
 *  查看 UNetworkType 枚举
 */
- (UNetworkType)networkType;

/**
 *  @abstract SDK版本
 */
- (NSString *)sdkVersion;

@end

NS_ASSUME_NONNULL_END
