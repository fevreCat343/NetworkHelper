//
//  FCNetworkHelper.h
//  NetworkHelper
//
//  Created by John on 15/12/9.
//  Copyright © 2015年 FeverCat. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPRequestOperation;
typedef enum {
    RequestTypeGet = 1 << 0,
    RequestTypePost = 1 << 1
} RequestType;
@protocol FCNetworkHelperDelegate <NSObject>

@required
/**
 *  网络请求成功回调
 **/
- (void)networkHelperSuccessWithResponseObject:(id)responseObject
                                   atOperation:(AFHTTPRequestOperation *)operation
                                           tag:(NSInteger)tag;

/**
 *  网络请求失败回调
 **/
- (void)networkHelperFailureWithResponseObject:(NSError *)error
                                   atOperation:(AFHTTPRequestOperation *)operation
                                           tag:(NSInteger)tag;

@end

@interface FCNetworkHelper : NSObject
@property (nonatomic, weak) id<FCNetworkHelperDelegate> delegate;

/**
 *  网络请求助手实例化方法
 **/
+ (instancetype)networkHelper;

/**
 *  网络请求
 *
 *  @param requestType 请求类型 GETorPOST
 *  @param urlStr      请求URL字符串
 *  @param params      请求参数
 *  @param tag         请求标识
 */
- (void)networkRequest:(RequestType)requestType
             urlString:(NSString *)urlStr
                params:(NSDictionary *)params
                   tag:(NSInteger)tag;

@end
