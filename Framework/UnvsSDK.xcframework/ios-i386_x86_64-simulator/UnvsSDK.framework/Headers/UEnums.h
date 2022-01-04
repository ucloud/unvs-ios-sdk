//
//  UEnums.h
//  UnvsSDK
//
//  Created by jdq on 2021/10/29.
//

#ifndef UEnums_h
#define UEnums_h

typedef NS_ENUM (NSUInteger, UCarrierType) {
    /// 未知
    UCarrierTypeUnknown = 0,
    /// 移动
    UCarrierTypeMobile,
    /// 联通
    UCarrierTypeUnicome,
    /// 电信
    UCarrierTypeTelecom
};

typedef NS_ENUM (NSInteger, UNetworkType) {
    /// 未知
    UNetworkTypeUnknown = -1,
    /// 无网络
    UNetworkTypeNotReachable,
    /// 数据流量
    UNetworkTypeCellular,
    /// WiFi
    UNetworkTypeWifi,
    /// 数据流量+WiFi
    UNetworkTypeCellularAndWifi
};

typedef NS_ENUM (NSInteger, UPresentationDirection) {
    /// present默认效果
    UPresentationDirectionPresent = 0,
    /// 右边，导航栏效果
    UPresentationDirectionPush
};

typedef NS_ENUM(NSInteger, UAuthWindowPopStyle) {
    /// 默认fullscreen
    UAuthWindowPopStyleFullscreen = -1,
    /// 居中模式
    UAuthWindowPopStyleCenter,
    /// 边缘弹出
    UAuthWindowPopStyleBottom
};

#endif /* UEnums_h */
