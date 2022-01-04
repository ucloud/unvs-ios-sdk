//
//  USAuthViewConfig.m
//  UnvsSDKDemo
//
//  Created by jdq on 2021/10/27.
//

#import "USAuthViewConfig.h"
#import <UnvsSDK/UnvsSDK.h>
#import "USMaskView.h"
#import "Masonry.h"
#import "USTools.h"
#import "Macros.h"
#import "USHud.h"

@interface USAuthViewConfig()
@property (nonatomic, strong) UAuthViewConfig *curentConfig;
@end

@implementation USAuthViewConfig

- (UAuthViewConfig *)loadConfigsWithFullscreen:(BOOL)fullscreen {
    UAuthViewConfig *config = [[UAuthViewConfig alloc] init];
    
    #pragma mark - 基础配置

    /// 授权页载入效果
    config.authWindowPopStyle = fullscreen ? UAuthWindowPopStyleFullscreen :  UAuthWindowPopStyleCenter;
    /// 页面presentDirection效果
    config.presentDirectionType = UPresentationDirectionPush;
    /// 授权页背景颜色
    config.authPageBackgroundColor = [UIColor colorNamed:@"#F9F9F9"];
    
    /// 横竖屏
    if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeLeft) {
        config.faceOrientation = UIInterfaceOrientationLandscapeLeft;
    } else if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeRight) {
        config.faceOrientation = UIInterfaceOrientationLandscapeRight;
    } else if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait) {
        config.faceOrientation = UIInterfaceOrientationPortrait;
    } else {
        config.faceOrientation = UIInterfaceOrientationPortrait;
    }
    
    if (config.faceOrientation != UIInterfaceOrientationPortrait) {
        /// 适配横屏下弹窗授权页
        config.authWindowScaleH = 0.8;
        config.authWindowScaleW = 0.35;
    }
    
    #pragma mark - 手机号码
    
    if (fullscreen) {
        config.phoneNumberOffsetY = 270.0;
    }
    
    #pragma mark - 运营商认证描述
    
    config.carrierAuthDescFont = [UIFont systemFontOfSize:13.0];
    
    if (fullscreen) {
        config.carrierAuthDescOffsetY = 400.0;
    }
    
    #pragma mark - 登录按钮
    
    config.loginButtonText = @"本机号码一键登录";
    config.loginButtonTextFont = [UIFont systemFontOfSize:15.0 weight:2.0];
    config.loginButtonRadius = 5.0;
    config.loginButtonHeight = 48.0;
    config.loginButtonBgColor = [UIColor colorNamed:@"#0656FF"];
    
    if (fullscreen) {
        config.loginButtonOffsetY = 330.0;
    }
    
    #pragma mark - 用户协议
    
    config.privacyText = @"阅读并同意《默认》并授权本机号码登录";
    config.privacyOffsetBottom = config.authWindowPopStyle == UAuthWindowPopStyleFullscreen ? 40.0 : 5.0;
    config.privacyProtocolColor = [UIColor colorNamed:@"#0656FF"];
    
    config.privacyHeight = 80;
    
    /// 隐私协议复选框大小
    config.checkboxSize = 16;
    /// 距离顶部距离
    config.checkboxTopSpacing = 3.2;
    /// 和隐私协议的间距
    config.checkboxSpacing = 3.0;
    /// 选中的icon
    config.checkedImg = [UIImage imageNamed:@"checked_icon"];
    /// 未选中的icon
    config.uncheckedImg = [UIImage imageNamed:@"unchecked_icon"];
    /// 复选框事件回调
    config.checkboxActionBlock = ^(BOOL checked) {
        NSLog(@"协议是否勾选: %@", checked ? @"已勾选" : @"未勾选");
    };
    
    /// 隐私协议web页面返回按钮
    config.privacyBackButtonImg = [UIImage imageNamed:@"back_icon_pop"];
    
    /// 隐私协议页面可自定义
//    config.privacyPageCustomBlock = ^(NSURL * _Nonnull url) {
//        /// 跳转到自定义授权页
//        NSLog(@"privacyPageCustom url %@", url);
//    };
    
    WeakSelf(self)
    
    #pragma mark - 登录按钮
    
    /// 登录按钮事件回调
    config.authLoginActionBlock = ^(BOOL checked) {
        if (!checked) {
            if (fullscreen) {
                [USHud showToastBottomMessage:@"请阅读并勾选服务协议条款"];
            } else {
                [USHud showToast:@"请阅读并勾选服务协议条款" offset:0.8];
            }
        }
    };
    
    #pragma mark - Loading
    
    /// 点击一键登录按钮时的loading，可自定义
    if (fullscreen) {
        config.uauthLoadingViewBlock = ^(UIView *loadingView) {
            [weakSelf customLoadingView:loadingView];
        };
    } else {
        config.uauthLoadingViewBlock = ^(UIView *loadingView) {
            
        };
    }
    
    #pragma mark - 自定义View

    config.authPageCustomViewBlock = ^(UIView * containView) {
        /// 以全屏模式举例
        if (fullscreen) {
            /// 导航栏
            [weakSelf customNavBarView:containView];
            /// Logo
            [weakSelf customAppLogoWithSuperView:containView];
            /// 更多登录方式
            [weakSelf moreLoginWithSuperView:containView];
        } else {
            /// 返回按钮
            [weakSelf navBackButtonWithSuperView:containView];
        }
    };
    
    _curentConfig = config;
    
    return config;
}

#pragma mark - 导航栏

- (void)customNavBarView:(UIView *)superView {
    /// navBar
    UIView *navBarView = [[UIView alloc] init];
    navBarView.backgroundColor = [UIColor whiteColor];
    [superView addSubview:navBarView];
    
    [navBarView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.mas_equalTo(44.0 + [USTools safeAreaInsets].top);
    }];
    
    /// backButton
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_icon_fullscreen"] forState:UIControlStateNormal];
    [navBarView addSubview:backButton];
    /// Target
    [backButton addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [backButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(navBarView.mas_bottom).offset(-10.0);
        make.left.mas_equalTo(navBarView.mas_left).offset(15.0);
        make.width.mas_equalTo(25.0);
        make.height.mas_equalTo(25.0);
    }];
    
    /// Title
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"快捷登录";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:16.0 weight:1.0];
    titleLab.textColor = [UIColor blackColor];
    [navBarView addSubview:titleLab];
    
    [titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backButton.mas_centerY).offset(0.5);
        make.centerX.equalTo(navBarView);
    }];
}

#pragma mark - 返回按钮

- (void)navBackButtonWithSuperView:(UIView *)superView{
    CGFloat backBtnOffsetTop = 20.0;
    
    NSString *icon = @"back_icon_pop";
    
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [superView addSubview:backButton];
    /// Action
    [backButton addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [backButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).offset(backBtnOffsetTop);
        make.right.mas_equalTo(superView).offset(-20.0);
        make.width.mas_equalTo(25.0);
        make.height.mas_equalTo(25.0);
    }];
}

#pragma mark - Logo

- (void)customAppLogoWithSuperView:(UIView *)superView {
    /// logoContainer
    UIView *logoContainView = [[UIView alloc] init];
    logoContainView.backgroundColor = [UIColor colorNamed:@"#0656FF"];
    logoContainView.layer.masksToBounds = YES;
    logoContainView.layer.cornerRadius = 38.0;
    [superView addSubview:logoContainView];
    
    [logoContainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).offset(160.0);
        make.centerX.equalTo(superView);
        make.width.mas_equalTo(76.0);
        make.height.mas_equalTo(76.0);
    }];
    
    /// logoImgView
    UIImageView *logoImgView = [[UIImageView alloc] init];
    logoImgView.image = [UIImage imageNamed:@"brand_logo"];
    [logoContainView addSubview:logoImgView];
    
    [logoImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(logoContainView);
        make.centerY.equalTo(logoContainView);
        make.width.mas_equalTo(33.0);
        make.height.mas_equalTo(33.0);
    }];
}

#pragma mark - 更多登录方式

- (void)moreLoginWithSuperView:(UIView *)superView {
    /// 示例为全屏模式下的布局
    if (_curentConfig.authWindowPopStyle == UAuthWindowPopStyleCenter) {
        return;
    }
    
    CGFloat moreLoginContainViewOffsetBottom = _curentConfig.privacyOffsetBottom + _curentConfig.privacyHeight;
    
    UIView *moreLoginContainView = [[UIView alloc] init];
    moreLoginContainView.userInteractionEnabled = YES;
    [superView addSubview:moreLoginContainView];
    
    [moreLoginContainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superView).offset(-moreLoginContainViewOffsetBottom);
        make.left.equalTo(superView).offset(60.0);
        make.right.equalTo(superView).offset(-60.0);
        make.height.mas_equalTo(120.0);
    }];
    
    /// word
    UILabel *moreWord = [[UILabel alloc] init];
    moreWord.text = @"其它登录方式";
    moreWord.textColor = UIColor.grayColor;
    moreWord.textAlignment = NSTextAlignmentCenter;
    moreWord.font = [UIFont systemFontOfSize:13.0];
    [moreLoginContainView addSubview:moreWord];
    
    [moreWord mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moreLoginContainView);
        make.centerX.equalTo(moreLoginContainView);
    }];
    
    /// lineLF
    UIView *lineLF = [[UIView alloc] init];
    lineLF.backgroundColor = [UIColor colorNamed:@"#E4E4E4"];
    [moreLoginContainView addSubview:lineLF];
  
    [lineLF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moreWord);
        make.left.equalTo(moreLoginContainView);
        make.right.equalTo(moreWord.mas_left).offset(-25.0);
        make.height.mas_equalTo(0.8);
    }];
    
    /// lineRT
    UIView *lineRT = [[UIView alloc] init];
    lineRT.backgroundColor = [UIColor colorNamed:@"#E4E4E4"];
    [moreLoginContainView addSubview:lineRT];
    
    [lineRT mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moreWord);
        make.left.equalTo(moreWord.mas_right).offset(25.0);
        make.right.equalTo(moreLoginContainView);
        make.height.mas_equalTo(0.8);
    }];
    
    /// QQ
    UIImageView *qqImgView = [[UIImageView alloc] init];
    qqImgView.image = [UIImage imageNamed:@"qq_login_icon"];
    qqImgView.userInteractionEnabled = YES;
    [moreLoginContainView addSubview:qqImgView];
    
    /// Tap Gesture
    UITapGestureRecognizer *qqTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qqAction)];
    [qqImgView addGestureRecognizer:qqTapGes];
   
    [qqImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moreWord.mas_top).offset(30.0);
        make.centerX.equalTo(moreLoginContainView);
        make.width.mas_equalTo(35.0);
        make.height.mas_equalTo(35.0);
    }];
    
    /// wechat
    UIImageView *wechatImgView = [[UIImageView alloc] init];
    wechatImgView.image = [UIImage imageNamed:@"wechat_login_icon"];
    wechatImgView.userInteractionEnabled = YES;
    [moreLoginContainView addSubview:wechatImgView];
    
    /// Tap Gesture
    UITapGestureRecognizer *wechatTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wechatAction)];
    [wechatImgView addGestureRecognizer:wechatTapGes];
 
    [wechatImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(qqImgView.mas_left).offset(-30.0);
        make.centerY.equalTo(qqImgView);
        make.width.mas_equalTo(35.0);
        make.height.mas_equalTo(35.0);
    }];
    
    /// AppleID
    UIImageView *appleIdImgView = [[UIImageView alloc] init];
    appleIdImgView.image = [UIImage imageNamed:@"apple_login_icon"];
    appleIdImgView.contentMode = UIViewContentModeScaleToFill;
    appleIdImgView.userInteractionEnabled = YES;
    [moreLoginContainView addSubview:appleIdImgView];
    
    /// Tap Gesture
    UITapGestureRecognizer *appleLoginTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(appleLoginAction)];
    [appleIdImgView addGestureRecognizer:appleLoginTapGes];

    [appleIdImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(qqImgView.mas_right).offset(30.0);
        make.centerY.equalTo(qqImgView);
        make.width.mas_equalTo(35.0);
        make.height.mas_equalTo(35.0);
    }];
}

#pragma mark - Loading

- (void)customLoadingView:(UIView *)superView {
    superView.backgroundColor = [UIColor whiteColor];
    superView.alpha = 0.7;
    
    UIImageView *loadingImageView = [[UIImageView alloc] init];
    loadingImageView.image = [UIImage imageNamed:@"loading_icon"];
    [superView addSubview:loadingImageView];
    
    [loadingImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView);
        make.centerY.equalTo(superView);
        make.width.mas_equalTo(35.0);
        make.height.mas_equalTo(35.0);
    }];
    
    /// Animation
    [USTools startCircleAnimation:loadingImageView];
}

#pragma mark - Action

- (void)backBtnAction {
    [USMaskView hide];
    [[UnvsManager shared] unloadLoginAuthorizePageAnimated:YES completion:nil];
}

- (void)qqAction {
    [USHud showToastBottomMessage:@"由开发者自己实现"];
}

- (void)wechatAction {
    [USHud showToastBottomMessage:@"由开发者自己实现"];
}

- (void)appleLoginAction {
    [USHud showToastBottomMessage:@"由开发者自己实现"];
}

@end
