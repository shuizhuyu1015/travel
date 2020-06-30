//
//  UMSocialHelper.h
//  tgjcarevip
//
//  Created by 泰管家 on 2017/3/23.
//  Copyright © 2017年 泰管家. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UShareUI/UShareUI.h>

typedef void (^ Success)(id responseObject);     // 成功Block
typedef void (^ Failure)(NSError *error);        // 失败Blcok

@interface UMSocialHelper : NSObject

+(id)shareInstance;

/*!
 @brief 分享内容到微信平台
 @param platformType 分享平台（微信会话/朋友圈）
 @param url 分享的网页地址
 @param title 分享的标题
 @param descr 分享的描述
 @param thumImage 缩略图（UIImage或者NSData类型，或者image_url）
 @param currentVC 用于弹出类似邮件分享、短信分享等这样的系统页面
 @param success 分享成功回调
 @param failure 分享失败回调
 */
-(void)shareToWeChatPlatform:(UMSocialPlatformType)platformType webUrl:(NSString *)url title:(NSString *)title description:(NSString *)descr thumImage:(id)thumImage currentVC:(id)currentVC success:(Success)success failure:(Failure)failure;

/*!
 @brief 分享内容到新浪微博
 @param platformType 分享平台（新浪）
 @param url 分享的网页地址
 @param descr 分享的描述
 @param shareImage（UIImage或者NSData类型，或者image_url）
 @param currentVC 用于弹出类似邮件分享、短信分享等这样的系统页面
 @param success 分享成功回调
 @param failure 分享失败回调
 */
-(void)shareToSinaPlatform:(UMSocialPlatformType)platformType webUrl:(NSString *)url description:(NSString *)descr shareImage:(id)shareImage currentVC:(id)currentVC success:(Success)success failure:(Failure)failure;

@end
