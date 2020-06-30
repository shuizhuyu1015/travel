//
//  AsrManager.m
//  Runner
//
//  Created by Gray on 2020/6/17.
//

#import "AsrManager.h"
#import "BDSASRDefines.h"
#import "BDSASRParameters.h"
#import "BDSEventManager.h"

//#error "请在百度AI官网新建应用，配置包名，并在此填写应用的 api key, secret key, appid(即appcode)"

const NSString* APP_ID = @"20422331";
const NSString* API_KEY = @"ciyfK2KGy6VDEbCeKm1jwqn8";
const NSString* SECRET_KEY = @"m6peK0T9OlMoCUGo3GD40EOTrYSgrVn6";

@interface AsrManager () <BDSClientASRDelegate>

@property (nonatomic, strong) BDSEventManager *asrEventManager;
@property (nonatomic, copy) AsrCallback asrSuccess;
@property (nonatomic, copy) AsrCallback asrFailure;

@end

@implementation AsrManager

+(instancetype)initWithSuccess:(AsrCallback)success failure:(AsrCallback)failure {
    AsrManager *manager = [[AsrManager alloc] init];
    manager.asrSuccess = success;
    manager.asrFailure = failure;
    return manager;
}

-(instancetype)init {
    if (self = [super init]) {
        _asrEventManager = [BDSEventManager createEventManagerWithName:BDS_ASR_NAME];
        [self configVoiceRecognitionClient];
    }
    return self;
}

#pragma mark - actions

-(void)start {
    [self.asrEventManager setDelegate:self];
//    长语音识别
//    [self.asrEventManager setParameter:@(NO) forKey:BDS_ASR_ENABLE_LONG_SPEECH];
//    [self.asrEventManager setParameter:@(NO) forKey:BDS_ASR_NEED_CACHE_AUDIO];
//    [self.asrEventManager setParameter:@"" forKey:BDS_ASR_OFFLINE_ENGINE_TRIGGERED_WAKEUP_WORD];
//    [self.asrEventManager setParameter:@(YES) forKey:BDS_ASR_ENABLE_LOCAL_VAD];
    
    [self.asrEventManager setParameter:nil forKey:BDS_ASR_AUDIO_FILE_PATH];
    [self.asrEventManager setParameter:nil forKey:BDS_ASR_AUDIO_INPUT_STREAM];
    
    [self.asrEventManager sendCommand:BDS_ASR_CMD_START];
}

-(void)stop {
    [self.asrEventManager sendCommand:BDS_ASR_CMD_STOP];
}

-(void)cancel {
    [self.asrEventManager sendCommand:BDS_ASR_CMD_CANCEL];
}

#pragma mark - Private: Configuration

- (void)configVoiceRecognitionClient {
    //设置DEBUG_LOG的级别
//    [self.asrEventManager setParameter:@(EVRDebugLogLevelTrace) forKey:BDS_ASR_DEBUG_LOG_LEVEL];
    //配置API_KEY 和 SECRET_KEY 和 APP_ID
    [self.asrEventManager setParameter:@[API_KEY, SECRET_KEY] forKey:BDS_ASR_API_SECRET_KEYS];
//    [self.asrEventManager setParameter:APP_ID forKey:BDS_ASR_OFFLINE_APP_CODE];
    
    //配置端点检测（二选一）
//    [self configModelVAD];
    [self configDNNMFE];
    
//    语义理解
//    [self.asrEventManager setParameter:@"15363" forKey:BDS_ASR_PRODUCT_ID];
    // ---- 语义与标点 -----
    //    [self enableNLU];
    //    [self enablePunctuation];
    // ------------------------
    
    //---- 语音自训练平台 ----
//        [self configSmartAsr];
}


- (void) enableNLU {
    // ---- 开启语义理解 -----
    [self.asrEventManager setParameter:@(YES) forKey:BDS_ASR_ENABLE_NLU];
    //    [self.asrEventManager setParameter:@"1536" forKey:BDS_ASR_PRODUCT_ID];
}

- (void) enablePunctuation {
    // ---- 开启标点输出 -----
    [self.asrEventManager setParameter:@(NO) forKey:BDS_ASR_DISABLE_PUNCTUATION];
    // 普通话标点
    //    [self.asrEventManager setParameter:@"1537" forKey:BDS_ASR_PRODUCT_ID];
    // 英文标点
    [self.asrEventManager setParameter:@"1737" forKey:BDS_ASR_PRODUCT_ID];
    
}

- (void)configModelVAD {
    NSString *modelVAD_filepath = [[NSBundle mainBundle] pathForResource:@"bds_easr_basic_model" ofType:@"dat"];
    [self.asrEventManager setParameter:modelVAD_filepath forKey:BDS_ASR_MODEL_VAD_DAT_FILE];
    [self.asrEventManager setParameter:@(YES) forKey:BDS_ASR_ENABLE_MODEL_VAD];
}

- (void)configDNNMFE {
    NSString *mfe_dnn_filepath = [[NSBundle mainBundle] pathForResource:@"bds_easr_mfe_dnn" ofType:@"dat"];
    [self.asrEventManager setParameter:mfe_dnn_filepath forKey:BDS_ASR_MFE_DNN_DAT_FILE];
    NSString *cmvn_dnn_filepath = [[NSBundle mainBundle] pathForResource:@"bds_easr_mfe_cmvn" ofType:@"dat"];
    [self.asrEventManager setParameter:cmvn_dnn_filepath forKey:BDS_ASR_MFE_CMVN_DAT_FILE];
    // 自定义静音时长
    //    [self.asrEventManager setParameter:@(501) forKey:BDS_ASR_MFE_MAX_SPEECH_PAUSE];
    //    [self.asrEventManager setParameter:@(500) forKey:BDS_ASR_MFE_MAX_WAIT_DURATION];
}

#pragma mark - MVoiceRecognitionClientDelegate

- (void)VoiceRecognitionClientWorkStatus:(int)workStatus obj:(id)aObj {
    switch (workStatus) {
        case EVoiceRecognitionClientWorkStatusNewRecordData: {
            
            break;
        }
            
        case EVoiceRecognitionClientWorkStatusStartWorkIng: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusStart: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusEnd: {

            break;
        }
        case EVoiceRecognitionClientWorkStatusFlushData: {

            break;
        }
        case EVoiceRecognitionClientWorkStatusFinish: {
            if ([aObj isKindOfClass:[NSDictionary class]]) {
                NSString *result = aObj[@"results_recognition"][0];
                if (self.asrSuccess) {
                    self.asrSuccess(result);
                }
            }
            break;
        }
        case EVoiceRecognitionClientWorkStatusMeterLevel: {
            break;
        }
        case EVoiceRecognitionClientWorkStatusCancel: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusError: {
            if (self.asrFailure) {
                self.asrFailure([(NSError *)aObj description]);
            }
            break;
        }
        case EVoiceRecognitionClientWorkStatusLoaded: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusUnLoaded: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusChunkThirdData: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusChunkNlu: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusChunkEnd: {

            break;
        }
        case EVoiceRecognitionClientWorkStatusFeedback: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusRecorderEnd: {
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusLongSpeechEnd: {
            
            break;
        }
        default:
            break;
    }
}


@end
