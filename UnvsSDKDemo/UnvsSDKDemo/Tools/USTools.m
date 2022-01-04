//
//  USTools.m
//  UnvsSDKDemo
//
//  Created by jdq on 2021/10/25.
//

#import "USTools.h"

@implementation USTools

+ (void)showAlertTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:confirmAction];
    /// Present
    if ([NSThread isMainThread]) {
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        });
    }
}

+ (UIEdgeInsets)safeAreaInsets {
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    return window.safeAreaInsets;
}

+ (void)startCircleAnimation:(UIView *)view {
    CABasicAnimation *basicAnimation = [[CABasicAnimation alloc] init];
    basicAnimation.keyPath = @"transform.rotation";
    basicAnimation.fromValue = @0;
    basicAnimation.toValue = @(M_PI * 2);
    basicAnimation.duration = 0.8;
    basicAnimation.repeatCount = HUGE;
    [view.layer addAnimation:basicAnimation forKey:@"CircleAnimationKey"];
}

+ (void)stopCircleAnimation:(UIView *)view {
    [view.layer removeAnimationForKey:@"CircleAnimationKey"];
}

@end
