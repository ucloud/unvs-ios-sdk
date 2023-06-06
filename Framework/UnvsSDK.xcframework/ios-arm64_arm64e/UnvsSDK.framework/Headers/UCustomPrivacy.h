//
//  UCustomPrivacy.h
//  UnvsSDK
//
//  Created by jdq on 2021/10/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UCustomPrivacy : NSObject

/// 开发者隐私协议名称
@property (nonatomic, copy) NSString *privacyProtocolName;

/// 开发者隐私协议URL
@property (nonatomic, copy) NSString *privacyProtocolUrl;

/**
 *  @abstract 初始化
 *  @param name 隐私协议名称
 *  @param url 隐私协议url
 */
- (instancetype)initWithName:(NSString *)name url:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
