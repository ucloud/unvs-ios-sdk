//
//  USTools.h
//  UnvsSDKDemo
//
//  Created by jdq on 2021/10/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface USTools : NSObject
/**
 *  @abstract 系统弹窗
 *
 *  @param title 标题
 *  @param message 详情
 */
+ (void)showAlertTitle:(NSString *)title message:(NSString *)message;

/**
 *  @abstract safeAreaInsets
 */
+ (UIEdgeInsets)safeAreaInsets;

/**
 *  @abstract 开始Circle动画
 *
 *  @param view 动画对象
 */
+ (void)startCircleAnimation:(UIView *)view;

/**
 *  @abstract 停止Circle动画
 *
 *  @param view 动画对象
 */
+ (void)stopCircleAnimation:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
