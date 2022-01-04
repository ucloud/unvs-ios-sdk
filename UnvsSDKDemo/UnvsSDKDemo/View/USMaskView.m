//
//  USMaskView.m
//  UnvsSDKDemo
//
//  Created by jdq on 2021/10/27.
//

#import "USMaskView.h"

@interface USMaskView()
@property (nonatomic, strong) UIView *showView;
@end

@implementation USMaskView

/// instance
+ (instancetype)instance {
    static USMaskView *_shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[USMaskView alloc] init];
    });
    return _shared;
}

/// show
+ (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
    
    UIView *maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    [window addSubview:maskView];
    
    [UIView animateWithDuration:0.589 animations:^{
        maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:[USMaskView instance] action:@selector(hide)];
    [maskView addGestureRecognizer:tapGes];
    
    [USMaskView instance].showView = maskView;
}

/// hide
+ (void)hide {
    [UIView animateWithDuration:0.25 animations:^{
        [USMaskView instance].showView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    } completion:^(BOOL finished) {
        if (finished) {
            [[USMaskView instance].showView removeFromSuperview];
        }
    }];
}
 
- (void)hide {
    [USMaskView hide];
}

@end
