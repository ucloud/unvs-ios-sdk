
# UCloud号码认证 iOS SDK 接入文档

| 日期 | 版本 | 说明 |
| --- | --- | --- |
| 2021-10-29 | 1.0.0 | UCloud号码认证iOS SDK，支持一键登录、本机号码检测。 |

## 一、目录
  - [一、目录](#一、目录)
  - [二、接入说明](#二、接入说明)
  - [三、SDK接口说明](#三、sdk接口说明)
      - [2.0 初始化SDK](#2-0初始化-sdk)
      - [2.1 预加载授权页（取号）](#2-1预加载授权页（取号）)
      - [2.2 加载授权页](#2-2加载授权页)
      - [2.3 关闭授权页](#2-3关闭授权页)
      - [2.4 本机号码校验Token获取](#2-4本机号码校验-token获取)
      - [2.5 日志打印](#2-5日志打印)
      - [2.6 超时设置](#2-6超时设置)
      - [2.7 运营商类型](#2-7运营商类型)
      - [2.8 连接网络类型](#2-8连接网络类型)
      - [2.9 SDK版本](#2-9-sdk版本)
  - [四、其他注意事项](#四、其他注意事项)

## 二、接入说明

开发环境：
* 最低部署版本：iOS 9.0及以上。
* Xcode开发工具：12.0及以上。

集成方式：

* 将`UnvsSDK.xcframework`拖拽到Xcode工程内（需要勾选Copy items if needed选项）。
* 点击项目target -> General -> Frameworks,Libraries,and Embedded Content -> UnvsSDK.xcframework，在Embed选项下，选择`Embed & Sign`。

-------

**一键登录使用步骤：**

* 导入头文件
```oc
#import <UnvsSDK/UnvsSDK.h>
```

* 初始化
```oc
// AppId在UCloud号码认证平台申请
[[UnvsManager shared] registerWithAppId:@"xxxxx"];
// 开启日志
[[UnvsManager shared] consolePrintLoggerEnable:YES];
// 设置超时
[[UnvsManager shared] setTimeoutInterval:6000];
```

* 预加载授权页（取号）
```oc
- (void)preLoadLoginAuthorizePageWithCompletion:(void(^)(NSError * _Nullable))completion;
```

* 加载授权页
```oc
- (void)loadLoginAuthorizePageWithViewConfig:(UAuthViewConfig *)viewConfig completion:(void (^)(NSError *error, NSString *token))completion;
```

* 关闭授权页
```oc
- (void)unloadLoginAuthorizePageAnimated:(BOOL)animated completion:(void (^_Nullable)(void))completion;
```

-------

**本机号码验证使用步骤：**

* 预加载授权页（取号）
```oc
- (void)preLoadLoginAuthorizePageWithCompletion:(void(^)(NSError * _Nullable))completion;
```

* 手机号码检测（获取验证Token）
```oc
- (void)verifyPhoneNumberCompletion:(void(^)(NSError * _Nullable, NSString * _Nullable))completion;
```

## 三、SDK接口说明

#### 2.0 初始化SDK
    
**接口描述** 

>  初始化SDK。

**接口示例**

```oc
[[UnvsManager shared] registerWithAppId:@"xxxxx"];
```

**参数说明**

> appId: UCloud号码认证平台申请应用ID。

-------

#### 2.1 预加载授权页（取号）

**接口描述** 

>  预加载授权页，使用前应先判断运营商信息、网络信息等。

**接口示例**

```oc
- (void)preLoadLoginAuthorizePageWithCompletion:(void(^)(NSError * _Nullable))completion;
```

**回调说明**

> 错误码:`200027`-->蜂窝网络未开启；`-10003`-->蜂窝网络权限未开启；其它错误码参照运营商错误码列表。

-------

#### 2.2 加载授权页

**接口描述** 

>  拉取授权页。

**接口示例**

```oc
- (void)loadLoginAuthorizePageWithViewConfig:(UAuthViewConfig *)viewConfig completion:(void (^)(NSError *error, NSString *token))completion;
```

**参数说明**

> viewConfig: 授权页配置model。

**回调说明**

> 错误码: 参照运营商错误码列表。
> token: 取号token，使用该token去开发者应用后台换取完整手机号码。

-------

#### 2.3 关闭授权页

**接口描述** 

>  关闭授权页。

**接口示例**

```oc
- (void)unloadLoginAuthorizePageAnimated:(BOOL)animated completion:(void (^_Nullable)(void))completion;
```

**参数说明**

> animated: 是否开启动画。

-------

#### 2.4 本机号码校验Token获取

**接口描述** 

>  本机号码校验Token获取。

**接口示例**

```oc
- (void)verifyPhoneNumberCompletion:(void(^)(NSError * _Nullable, NSString * _Nullable))completion;
```

**回调说明**

> 错误码: 参照运营商错误码列表。
> token: 本机号码验证token，使用该token去开发者应用后台验证是否是本机手机号码。

-------

#### 2.5 日志打印

**接口描述** 

>  日志打印。

**接口示例**

```oc
- (void)consolePrintLoggerEnable:(BOOL)enable;
```

**参数说明**

> enable: 是否开启控制台日志打印。

-------

#### 2.6 超时设置

**接口描述** 

>  超时设置。

**接口示例**

```oc
- (void)setTimeoutInterval:(NSTimeInterval)interval;
```

**参数说明**

> interval: 单位毫秒，建议设置为8000毫秒。

-------

#### 2.7 运营商类型

**接口描述** 

>  运营商类型。

**接口示例**

```oc
- (UCarrierType)carrierType;
```

**参数说明**

> UCarrierType: 
> 
`UCarrierTypeUnknown`-->未知；

`UCarrierTypeMobile`-->中国移动; 

`UCarrierTypeUnicome`-->中国联通;

`UCarrierTypeTelecom`-->中国电信。

-------

#### 2.8 连接网络类型

**接口描述** 

>  当前连接网络类型。

**接口示例**

```oc
- (UNetworkType)networkType;
```

**参数说明**

> UNetworkType:
> 
`UNetworkTypeUnknown`-->未知

`UNetworkTypeNotReachable`-->无网络

`UNetworkTypeCellular`-->数据流量

`UNetworkTypeWifi`-->WiFi

`UNetworkTypeCellularAndWifi`-->数据流量+WiFi

-------

#### 2.9 SDK版本

**接口描述** 

>  当前SDK版本。

**接口示例**

```oc
- (NSString *)sdkVersion;
```

## 四、其他注意事项

其它接口的使用方法，请参考Demo中的示例。
        

	
