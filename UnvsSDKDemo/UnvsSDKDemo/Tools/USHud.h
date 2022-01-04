//
//  USHud.h
//  UnvsSDKDemo
//
//  Created by jdq on 2021/10/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface USHud : NSObject

/**
 *  @abstract Toast提示
 *  @param message 提示信息
 */
+ (void)showToast:(NSString *)message;

/**
 *  @abstract Toast提示（屏幕底部展示）
 *  @param message 提示信息
 */
+ (void)showToastBottomMessage:(NSString *)message;

/**
 *  @abstract Toast提示
 *  @param message 提示信息
 *  @param offset 位置偏移
 */
+ (void)showToast:(NSString *)message offset:(CGFloat)offset;

/**
 *  @abstract 展示Loading
 *  @param message 提示信息
 */
+ (void)showLoading:(NSString *)message;

/**
 *  @abstract 隐藏Loading
 */
+ (void)hideLoading;

@end

NS_ASSUME_NONNULL_END
