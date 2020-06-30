//
//  AsrManager.h
//  Runner
//
//  Created by Gray on 2020/6/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AsrCallback)(NSString *message);

@interface AsrManager : NSObject

+(instancetype)initWithSuccess:(AsrCallback)success failure:(AsrCallback)failure;

-(void)start;
-(void)stop;
-(void)cancel;

@end

NS_ASSUME_NONNULL_END
