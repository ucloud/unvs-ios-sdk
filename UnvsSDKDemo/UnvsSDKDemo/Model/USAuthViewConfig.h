//
//  USAuthViewConfig.h
//  UnvsSDKDemo
//
//  Created by jdq on 2021/10/27.
//

#import <Foundation/Foundation.h>

@class UAuthViewConfig;

NS_ASSUME_NONNULL_BEGIN

@interface USAuthViewConfig : NSObject

/**
 *  @abstract 授权页配置
 *  @param fullscreen 是否全屏展示
 */
- (UAuthViewConfig *)loadConfigsWithFullscreen:(BOOL)fullscreen;

@end

NS_ASSUME_NONNULL_END
