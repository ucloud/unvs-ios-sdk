//
//  UAuthViewConfig.h
//  UnvsSDK
//
//  Created by jdq on 2021/10/18.
//

#import <UIKit/UIkit.h>
#import <UnvsSDK/UEnums.h>

NS_ASSUME_NONNULL_BEGIN

@class UCustomPrivacy;

@interface UAuthViewConfig : NSObject

#pragma mark - 基础配置

/// 当前ViewController，一键登录必传
@property (nonatomic, weak) UIViewController *currentVC;
/// 页面presentDirection效果
@property (nonatomic, assign) UPresentationDirection presentDirectionType;
/// 授权页窗口是否需要动画弹出，默认YES
@property (nonatomic, assign) BOOL presentAnimated;
/// 授权页窗口模式弹出样式
@property (nonatomic, assign) UAuthWindowPopStyle authWindowPopStyle;
/// 授权页窗口模式推出动画，默认UIModalTransitionStyleCrossDissolve
@property (nonatomic, assign) UIModalTransitionStyle modalTransitionStyle;
/// 授权页窗口模式，缩放比例，宽，默认0.8（屏幕宽度相乘）
@property (nonatomic, assign) CGFloat authWindowScaleW;
/// 授权页窗口模式，缩放比例，高，默认0.45（屏幕高度相乘）
@property (nonatomic, assign) CGFloat authWindowScaleH;
/// 授权页窗口模式，窗口视图圆角，默认10.0
@property (nonatomic, assign) CGFloat authWindowRadius;
/// 授权页边缘弹出模式，视图大小
@property (nonatomic,assign) CGSize controllerSize;
/// 授权页背景图片
@property (nonatomic, strong) UIImage *authPageBackgroundImage;
/// 授权页背景颜色
@property (nonatomic, strong) UIColor *authPageBackgroundColor;
/// 自定义一键登录loading（回调默认关闭，如需自己控制关闭，可使用keywindow并在一键登录回调中关闭）
@property (nonatomic, copy) void(^uauthLoadingViewBlock)(UIView *loadingView);
/// 授权页状态栏颜色
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
/// 授权页自定义控件（可自定义导航栏、更多登录方式...）
@property (nonatomic, copy) void(^authPageCustomViewBlock)(UIView *containView);
/// 授权页支持方向（横屏、竖屏）
@property (nonatomic, assign) UIInterfaceOrientation faceOrientation;

#pragma mark - 手机号码

/// 手机号码X轴偏移量，默认0居中显示
@property (nonatomic, assign) CGFloat phoneNumberOffsetX;
/// 手机号码Y轴偏移量，fullScreen默认180.0，窗口模式默认80.0（距离屏幕顶部）
@property (nonatomic, assign) CGFloat phoneNumberOffsetY;
/// 手机号码字体颜色，默认黑色
@property (nonatomic, strong) UIColor *phoneNumberColor;
/// 手机号码字体，默认系统字体20号
@property (nonatomic, strong) UIFont *phoneNumberFont;

#pragma mark - 运营商认证描述
/// 运营商认证描述文本（默认：XXX运营商提供认证服务）
@property (nonatomic, copy) NSString *carrierAuthDescText;
/// 运营商认证描述X轴偏移量，默认0居中显示
@property (nonatomic, assign) CGFloat carrierAuthDescOffsetX;
/// 运营商认证描述Y轴偏移量，fullScreen默认210.0，窗口模式默认110.0（距离屏幕顶部）
@property (nonatomic, assign) CGFloat carrierAuthDescOffsetY;
/// 运营商认证描述字体颜色，默认灰色
@property (nonatomic, strong) UIColor *carrierAuthDescColor;
/// 运营商认证描述字体，默认系统字体12号
@property (nonatomic, strong) UIFont *carrierAuthDescFont;
/// 运营商认证描述隐藏，默认NO
@property (nonatomic, assign) BOOL carrierAuthDescHidden;

#pragma mark - 登录按钮

/// 登录按钮Y轴偏移量，默认260.0（距离屏幕顶部）
@property (nonatomic, assign) CGFloat loginButtonOffsetY;
/// 登录按钮左边距，默认40.0
@property (nonatomic, assign) CGFloat loginButtonMarginLeft;
/// 登录按钮右边距，默认40.0
@property (nonatomic, assign) CGFloat loginButtonMarginRight;
/// 登录按钮高度，默认44.0
@property (nonatomic, assign) CGFloat loginButtonHeight;
/// 登录按钮文本
@property (nonatomic, copy) NSString *loginButtonText;
/// 登录按钮字体，默认系统字体15号
@property (nonatomic, strong) UIFont *loginButtonTextFont;
/// 登录按钮文本颜色，默认白色
@property (nonatomic, strong) UIColor *loginButtonTextColor;
/// 登录按钮圆角，默认10.0
@property (nonatomic, assign) CGFloat loginButtonRadius;
/// 登录按钮背景颜色，默认蓝色
@property (nonatomic, strong) UIColor *loginButtonBgColor;
/// 登录按钮激活状态下的背景图片，默认nil
@property (nonatomic, strong) UIImage *loginButtonNormalImg;
/// 登录按钮点击事件，checked：隐私协议是否勾选，checkbox隐藏时，默认勾选
@property (nonatomic, copy) void(^authLoginActionBlock)(BOOL checked);

#pragma mark - 协议复选框

/// 复选框选中时的图片，注意：SDK不提供默认icon
@property (nonatomic, strong) UIImage *checkedImg;
/// 复选框未选中时的图片，注意：SDK不提供默认icon
@property (nonatomic, strong) UIImage *uncheckedImg;
/// 复选框大小，默认12
@property (nonatomic, assign) CGFloat checkboxSize;
/// 复选框默认状态，默认NO
@property (nonatomic, assign) BOOL checkboxSelected;
/// 复选框是否隐藏，默认NO
@property (nonatomic, assign) BOOL checkboxHidden;
/// 复选框和隐私协议的间距， 默认3.0
@property (nonatomic, assign) CGFloat checkboxSpacing;
/// 复选框和隐私协议顶部的间距， 默认0.0
@property (nonatomic, assign) CGFloat checkboxTopSpacing;
/// 复选框事件回调
@property (nonatomic, copy) void(^checkboxActionBlock)(BOOL checked);

#pragma mark - 隐私协议

/// 隐私协议内容
/// 说明：全句可自定义，但必须保留《默认》标识SDK默认协议，否则不生效
/// 举个栗子👇🏻：
/// privacyText的内容：请阅读并同意《默认》百度协议&1腾讯协议&2并授权App获取本机号码
/// 最终展示：请阅读并同意中国移动协议百度协议腾讯协议并授权App获取本机号码
@property (nonatomic, copy) NSString *privacyText;
/// 隐私协议字体，默认系统字体13号
@property (nonatomic, strong) UIFont *privacyFont;
/// 隐私协议字体颜色，默认灰色
@property (nonatomic, strong) UIColor *privacyColor;
/// 隐私协议字距，默认0
@property (nonatomic, assign) int privacyWordSpacing;
/// 隐私协议行距，默认5
@property (nonatomic, assign) int privacyLineSpacing;
/// 是否显示隐私协议条款书名号《》，默认显示
@property (nonatomic, assign) BOOL showPrivacyProtocolMarks;
/// 隐私协议条款字体颜色，默认蓝色
@property (nonatomic, strong) UIColor *privacyProtocolColor;
/// 隐私协议距离屏幕左边的距离，默认52.0
@property (nonatomic, assign) CGFloat privacyOffsetLeft;
/// 隐私协议距离屏幕右边的距离，默认40.0
@property (nonatomic, assign) CGFloat privacyOffsetRight;
/// 隐私协议距离屏幕顶部的距离，不使用默认-1，注意：不能和privacyOffsetBottom同时使用
@property (nonatomic, assign) CGFloat privacyOffsetTop;
/// 隐私协议距离屏幕底部的距离，不使用默认-1，注意：不能和privacyOffsetTop同时使用
@property (nonatomic, assign) CGFloat privacyOffsetBottom;
/// 隐私协议高度，默认70.0
@property (nonatomic, assign) CGFloat privacyHeight;
/// 开发者隐私协议，注意：最多两个，超出不生效；协议顺序和个数需和privacyText里的一致
@property (nonatomic, strong) NSArray<UCustomPrivacy *> *customPrivacies;
/// 隐私协议界面自定义时需要调用该block
@property (nonatomic, copy) void(^privacyPageCustomBlock)(NSURL *url);
/// 隐私协议界面，返回按钮图标
@property (nonatomic, strong) UIImage *privacyBackButtonImg;

#pragma mark - 多语言

@property (nonatomic, assign) ULanguageType languageType;

@end

NS_ASSUME_NONNULL_END
