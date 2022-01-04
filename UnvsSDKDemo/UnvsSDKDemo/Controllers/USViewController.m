//
//  USViewController.m
//  UnvsSDKDemo
//
//  Created by jdq on 2021/10/20.
//

#import "USViewController.h"
#import "USAuthViewConfig.h"
#import <UnvsSDK/UnvsSDK.h>

#import "USMaskView.h"
#import "USTools.h"
#import "Macros.h"
#import "USHud.h"

#import "Masonry.h"

@interface USViewController ()
/// brandContainView
@property (weak, nonatomic) IBOutlet UIView *brandContainView;
/// 品牌logo
@property (weak, nonatomic) IBOutlet UIImageView *brandIconImg;
/// 品牌词
@property (weak, nonatomic) IBOutlet UILabel *brandTitleLab;
/// bottomContainView
@property (weak, nonatomic) IBOutlet UIView *bottomContainView;
/// 一键登录（全屏）
@property (weak, nonatomic) IBOutlet UIButton *loginFullscreenButton;
/// 一键登录（弹窗）
@property (weak, nonatomic) IBOutlet UIButton *loginWindowButton;
/// 版本声明
@property (weak, nonatomic) IBOutlet UILabel *copyrightLab;
/// 授权页配置model
@property (nonatomic, strong) USAuthViewConfig *uauthModel;
@end

@implementation USViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *v = [[UnvsManager shared] sdkVersion];
    NSLog(@"UnvsSDK Version %@", v);
    // 横竖屏约束
    CGRect rect = self.view.frame;
    if (rect.size.width < rect.size.height) {
        [self makePortraitConstraints];
    } else {
        [self makeLandscapeConstraints];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    /// 当前网络类型
    [self currentNetworkType];
    /// 当前运营商类型
    [self currentCarrier];
}

#pragma mark - Action

/**
 *  @abstract 一键登录（全屏）
 */
- (IBAction)loginFullScreenButtonAction:(id)sender {
    /// 预加载授权页
    [self preLoadAuthPage:YES];
}

/**
 *  @abstract 一键登录（弹窗）
 */
- (IBAction)loginPopWindowButtonAction:(id)sender {
    /// 预加载授权页
    [self preLoadAuthPage:NO];
}

#pragma mark - Business

/// 1.预加载授权页
- (void)preLoadAuthPage:(BOOL)fullscreen {
    /// 检查当前网络
    if ([UnvsManager.shared networkType] == UNetworkTypeUnknown || [UnvsManager.shared networkType] == UNetworkTypeNotReachable) {
        [USHud showToast:@"当前网络不可用"];
        return;
    }
    /// 检查当前运营商
    if ([UnvsManager.shared carrierType] == UCarrierTypeUnknown) {
        [USHud showToast:@"当前运营商类型：未知"];
        return;
    }
    
    /// loading
    [USHud showLoading:@"正在载入"];
    
    WeakSelf(self)
    [[UnvsManager shared] preLoadLoginAuthorizePageWithCompletion:^(NSError * _Nonnull error) {
        if (error) {
            [USHud hideLoading];
            /// 常见错误码：200023-->蜂窝网络未开启或不稳定；-10003-->蜂窝网络权限未开启
            [USTools showAlertTitle:@"提示" message:error.userInfo[NSLocalizedDescriptionKey]];
            return;
        }
        /// 加载授权页
        [weakSelf loadAuthPage:fullscreen];
    }];
}

/// 2.加载授权页
- (void)loadAuthPage:(BOOL)fullscreen {
    WeakSelf(self)
    /// 自定义授权页View样式
    _uauthModel = [[USAuthViewConfig alloc] init];
    UAuthViewConfig *config = [_uauthModel loadConfigsWithFullscreen:fullscreen];
    
    /// 当前VC，必传
    config.currentVC = self;
    
    /// 监听授权页拉起成功回调
    [UnvsManager shared].authPageCompleteBlock = ^{
        [USHud hideLoading];
        /// 弹窗模式自定义遮罩
        if (config.authWindowPopStyle != UAuthWindowPopStyleFullscreen) {
            [USMaskView show];
        }
    };
    
    /// 拉起授权页
    [[UnvsManager shared] loadLoginAuthorizePageWithViewConfig:config completion:^(NSError * _Nonnull error, NSString * _Nonnull token) {
        [USHud hideLoading];
        if (error) {
            [USTools showAlertTitle:@"提示" message:@"加载授权页失败"];
            return;
        }
        /// dismiss授权页
        [weakSelf unloadAuthPage];
        /// 成功获取到token
        if (token && token.length > 0) {
            NSLog(@"成功获取到token %@", token);
            NSString *message = [NSString stringWithFormat:@"取号token获取成功"];
            [USTools showAlertTitle:@"提示" message:message];
            /// 使用该token到开发者自己服务器换取完整的手机号...成功则代表`一键登录`整个流程完成。
        }
    }];
}

/// dismiss授权页
- (void)unloadAuthPage {
    /// 隐藏遮罩
    [USMaskView hide];
    /// dismiss授权页
    [[UnvsManager shared] unloadLoginAuthorizePageAnimated:YES completion:nil];
}

#pragma mark - 屏幕旋转回调

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if (size.width > size.height) {
        /// 横屏设置
        [self makeLandscapeConstraints];
    } else {
        /// 竖屏设置
        [self makePortraitConstraints];
    }
}

/// 竖屏
- (void)makePortraitConstraints {
    /// brandContainView
    self.brandContainView.layer.cornerRadius = 0.0;
    self.brandContainView.layer.masksToBounds = NO;
    [self.brandContainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(self.view).multipliedBy(0.48);
    }];
   
    /// brandIconImg
    [self.brandIconImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.brandContainView);
        make.centerY.mas_equalTo(self.brandContainView).offset(-20);
        make.width.mas_equalTo(65.0);
        make.height.mas_equalTo(65.0);
    }];
    
    /// brandTitleLab
    self.brandTitleLab.hidden = NO;
    [self.brandTitleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.brandContainView);
        make.top.equalTo(self.brandIconImg.mas_bottom).offset(40);
    }];
    
    /// bottomContainView
    [self.bottomContainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.brandContainView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    /// loginButton（fullscreen）
    self.loginFullscreenButton.hidden = NO;
    [self.loginFullscreenButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomContainView).multipliedBy(0.6);
        make.left.equalTo(self.bottomContainView.mas_left).offset(40);
        make.right.equalTo(self.bottomContainView.mas_right).offset(-40);
        make.height.mas_equalTo(55);
    }];
    
    /// loginButton（window）
    [self.loginWindowButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginFullscreenButton.mas_bottom).offset(25);
        make.left.equalTo(self.bottomContainView.mas_left).offset(40);
        make.right.equalTo(self.bottomContainView.mas_right).offset(-40);
        make.height.mas_equalTo(55);
    }];
    
    /// copyright
    [self.copyrightLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomContainView);
        make.bottom.equalTo(self.bottomContainView.mas_bottom).offset(-45);
    }];
}

/// 横屏（以弹窗示例）
- (void)makeLandscapeConstraints {
    /// brandContainView
    self.brandContainView.layer.cornerRadius = 45.0;
    self.brandContainView.layer.masksToBounds = YES;
    [self.brandContainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30.0);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(90);
    }];
    
    /// brandIconImg
    [self.brandIconImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.brandContainView);
        make.centerY.equalTo(self.brandContainView);
        make.width.mas_equalTo(40.0);
        make.height.mas_equalTo(40.0);
    }];
    
    /// brandTitleLab
    self.brandTitleLab.hidden = YES;
    
    /// loginButton（fullscreen）
    self.loginFullscreenButton.hidden = YES;
    
    /// loginButton（window）
    [self.loginWindowButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.centerX.equalTo(self.bottomContainView);
        make.width.mas_equalTo(self.bottomContainView).multipliedBy(0.35);
        make.height.mas_equalTo(55);
    }];
    
    /// copyright
    [self.copyrightLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomContainView);
        make.bottom.equalTo(self.bottomContainView.mas_bottom).offset(-40);
    }];
}

#pragma mark - Other

- (void)currentCarrier {
    switch ([UnvsManager.shared carrierType]) {
    case UCarrierTypeUnknown:
        NSLog(@"运营商：未知");
        break;
    case UCarrierTypeMobile:
        NSLog(@"运营商：中国移动");
        break;
    case UCarrierTypeUnicome:
        NSLog(@"运营商：中国联通");
        break;
    case UCarrierTypeTelecom:
        NSLog(@"运营商：中国电信");
        break;
    default:
        break;
    }
}

- (void)currentNetworkType {
    switch ([UnvsManager.shared networkType]) {
    case UNetworkTypeUnknown:
        NSLog(@"网络类型：未知");
        break;
    case UNetworkTypeCellular:
        NSLog(@"网络类型：数据流量");
        break;
    case UNetworkTypeWifi:
        NSLog(@"网络类型：wifi");
        break;
    case UNetworkTypeCellularAndWifi:
        NSLog(@"网络类型：数据流量+WiFi");
        break;
    case UNetworkTypeNotReachable:
        NSLog(@"网络不可用");
        break;

    default:
        break;
    }
}

@end
