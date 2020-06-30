//
//  UMSocialHelper.m
//  tgjcarevip
//
//  Created by 泰管家 on 2017/3/23.
//  Copyright © 2017年 泰管家. All rights reserved.
//

#import "UMSocialHelper.h"

@implementation UMSocialHelper

//获取友盟分享类示例
+(id)shareInstance
{
    static UMSocialHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (helper == nil) {
            helper = [[UMSocialHelper alloc] init];
        }
    });
    return helper;
}

-(void)shareToWeChatPlatform:(UMSocialPlatformType)platformType webUrl:(NSString *)url title:(NSString *)title description:(NSString *)descr thumImage:(id)thumImage currentVC:(id)currentVC success:(Success)success failure:(Failure)failure
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:(thumImage ? thumImage : [UIImage imageNamed:@"logo"])];
    //设置网页地址
    shareObject.webpageUrl = url;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:currentVC completion:^(id data, NSError *error) {
        if (error) {
            if (failure) {
                failure(error);
            }
        }else{
            if (success) {
                success(data);
            }
        }
    }];
}

-(void)shareToSinaPlatform:(UMSocialPlatformType)platformType webUrl:(NSString *)url description:(NSString *)descr shareImage:(id)shareImage currentVC:(id)currentVC success:(Success)success failure:(Failure)failure
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    if (descr.length > (140-3-url.length)) {
        descr = [descr substringToIndex:137-url.length];
    }
    messageObject.text = [NSString stringWithFormat:@"%@...%@", descr, url];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    [shareObject setShareImage:(shareImage ? shareImage : [UIImage imageNamed:@"logo"])];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:currentVC completion:^(id data, NSError *error) {
        if (error) {
            if (failure) {
                failure(error);
            }
        }else{
            if (success) {
                success(data);
            }
        }
    }];
}

@end
