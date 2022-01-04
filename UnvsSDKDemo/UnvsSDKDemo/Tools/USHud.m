//
//  USHud.m
//  UnvsSDKDemo
//
//  Created by jdq on 2021/10/26.
//

#import "USHud.h"

@interface USHud()
@property (nonatomic, strong) UIView *showView;
@end

@implementation USHud

#pragma mark - Toast

+ (void)showToast:(NSString *)message {
    /// 默认居中
    [self showToast:message offset:0.5];
}

+ (void)showToastBottomMessage:(NSString *)message {
    /// 底部
    [self showToast:message offset:0.63];
}

+ (void)showToast:(NSString *)message offset:(CGFloat)offset {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    UILabel *toastLab = [[UILabel alloc] init];
    toastLab.frame = CGRectMake(0, 0, 190, 40);
    toastLab.center = CGPointMake(width / 2.0, height * offset);
    toastLab.text = message;
    toastLab.textAlignment = NSTextAlignmentCenter;
    toastLab.font = [UIFont systemFontOfSize:13.0];
    toastLab.textColor = [UIColor whiteColor];
    toastLab.backgroundColor = [UIColor blackColor];
    
    toastLab.layer.masksToBounds = YES;
    toastLab.layer.cornerRadius = 5;
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [window addSubview:toastLab];
    
    /// delay hide
    void (^delayHideBlock)(void) = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5f animations:^{
                toastLab.alpha = 0.0;
            } completion:^(BOOL finished) {
                if (finished) {
                    [toastLab removeFromSuperview];
                }
            }];
        });
    };
    
    /// Animation
    toastLab.alpha = 0.0;
    
    [UIView animateWithDuration:0.3f animations:^{
        toastLab.alpha = 1.0;
    } completion:^(BOOL finished) {
        if (finished) {
            delayHideBlock();
        }
    }];
}

#pragma mark - Loading

+ (instancetype)instance {
    static USHud *_shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[USHud alloc] init];
    });
    return _shared;
}

+ (void)showLoading:(NSString *)message {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    
    /// backgroundView
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.frame = CGRectMake(0, 0, width, height);
    backgroundView.backgroundColor = UIColor.clearColor;
    [window addSubview:backgroundView];
    
    [USHud instance].showView = backgroundView;
    
    /// containView
    UIView *containView = [[UIView alloc] init];
    containView.frame = CGRectMake(0, 0, 78, 75);
    containView.center = CGPointMake(width / 2.0, height / 2.0);
    containView.backgroundColor = [UIColor blackColor];
    containView.layer.masksToBounds = YES;
    containView.layer.cornerRadius = 5.0;
    
    [backgroundView addSubview:containView];
    
    CGFloat conWidth = containView.frame.size.width;
    CGFloat conHeight = containView.frame.size.height;
    
    /// UIActivityIndicatorView
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] init];
    activityIndicator.color = UIColor.whiteColor;
    activityIndicator.center = CGPointMake(conWidth / 2.0, conHeight / 2.0 - 10.0);
    [activityIndicator startAnimating];
    [containView addSubview:activityIndicator];
    
    /// UILabel
    UILabel *descLab = [[UILabel alloc] init];
    descLab.text = message;
    descLab.textColor = UIColor.whiteColor;
    descLab.textAlignment = NSTextAlignmentCenter;
    descLab.font = [UIFont systemFontOfSize:12.0];
    descLab.frame = CGRectMake(0, 0, conWidth, 30.0);
    descLab.center = CGPointMake(conWidth / 2.0, conHeight / 2.0 + 15.0);
    [containView addSubview:descLab];
}

+ (void)hideLoading{
    [[USHud instance].showView removeFromSuperview];
}

@end
