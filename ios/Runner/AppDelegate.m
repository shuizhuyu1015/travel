#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

#import "AsrManager.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import "UMSocialHelper.h"
#import <WXApi.h>

#define UM_APPKEY @"567cf069e0f55a32fd0003ac"   //友盟appkey
#define WX_APPID @"wx15d5600fef8c75ce"  //微信appkey
#define WX_SECRET @"95efc8888666c74642914dac2c8459ad"
#define UNIVERSAL_LINK @"https://smuszh.tgj-care.com/"

@interface AppDelegate ()

@property (nonatomic, strong) AsrManager *asrManager;
@property (nonatomic, copy) FlutterResult asrResult;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 1.获取FlutterViewController(是应用程序的默认Controller)
    FlutterViewController *controller = (FlutterViewController *)self.window.rootViewController;
    
    // 2.获取MethodChannel(方法通道)
    FlutterMethodChannel *asrChannel = [FlutterMethodChannel methodChannelWithName:@"gray.com/asr" binaryMessenger:controller.binaryMessenger];
    
    // 3.监听方法调用(会调用传入的回调函数)
    __weak typeof(self) weakSelf = self;
    [asrChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        // 3.1.判断是否是dart方法的调用
        if ([call.method isEqualToString:@"start"]) {
            NSLog(@"iOS录音开始");
            weakSelf.asrResult = result;
            // iOS原生开始获取语音
            [weakSelf.asrManager start];
        }else if ([call.method isEqualToString:@"stop"]) {
            NSLog(@"iOS录音结束");
            [weakSelf.asrManager stop];
        }else if ([call.method isEqualToString:@"cancel"]) {
            [weakSelf.asrManager cancel];
        }else {
            result(FlutterMethodNotImplemented);
        }
    }];
    
    // 友盟
    [self setUMConfig];
    FlutterMethodChannel *shareChannel = [FlutterMethodChannel methodChannelWithName:@"gray.com/share" binaryMessenger:controller.binaryMessenger];
    [shareChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"showShare"]) {
            [weakSelf showShareHandler:result currentVC:controller];
        }
    }];
    
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler
{
    NSString *url = userActivity.webpageURL.absoluteString;
    NSLog(@"webpageURL:%@", url);
    
    return [[UMSocialManager defaultManager] handleUniversalLink:userActivity options:nil];
}

#pragma mark - 友盟分享
-(void)setUMConfig {
    //注册微信
    [WXApi registerApp:WX_APPID universalLink:UNIVERSAL_LINK];
    [UMConfigure initWithAppkey:UM_APPKEY channel:nil];
    [UMConfigure setLogEnabled:YES];//设置打开日志
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WX_APPID appSecret:WX_SECRET redirectURL:@"https://www.tgjcare.com"];
}
-(void)showShareHandler:(FlutterResult)result currentVC:(UIViewController *)vc {
    //显示分享面板
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    
    // 修改分享面板配置参数：肖像模式下底部3列
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForPortraitAndBottom = 2;
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        NSString *url = @"http://a.app.qq.com/o/simple.jsp?pkgname=com.tgjcare.tgjhealth";
        NSString *descr = @"泰管家创建了集“体检预约、报告查询、数据分析、健康档案、健康管理、在线咨询、就医服务”为一体的健康服务平台。第三方体检平台更中立公正；即时咨询更便捷；个性化指导更专业！泰管家致力为您打造365天零就医健康生活！";
        
        if (platformType == UMSocialPlatformType_WechatSession || platformType == UMSocialPlatformType_WechatTimeLine) {
            
            NSString *title = @"下载泰管家，享受个性化体检和私人医生管家服务，开启您的健康生活！";
            [[UMSocialHelper shareInstance] shareToWeChatPlatform:platformType webUrl:url title:title description:descr thumImage:[UIImage imageNamed:@"logo"] currentVC:vc success:^(id responseObject) {
                result(@YES);
            } failure:^(NSError *error) {
                result(@NO);
            }];
        }
    }];
}

#pragma mark - 语音识别懒加载
-(AsrManager *)asrManager {
    if (_asrManager == nil) {
        _asrManager = [AsrManager initWithSuccess:^(NSString * _Nonnull message) {
            // 通过result将结果回调给Flutter端
            if (self.asrResult) {
                self.asrResult(message);
                self.asrResult = nil;
            }
        } failure:^(NSString * _Nonnull message) {
            // 如果没有获取到,那么返回给Flutter端一个异常
            if (self.asrResult) {
                self.asrResult([FlutterError errorWithCode:@"asr fail" message:message details:nil]);
                self.asrResult = nil;
            }
        }];
    }
    return _asrManager;
}

@end
