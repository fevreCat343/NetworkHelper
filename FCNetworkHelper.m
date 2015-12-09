//
//  FCNetworkHelper.m
//  gitDemo
//
//  Created by John on 15/12/9.
//  Copyright © 2015年 FeverCat. All rights reserved.
//

#import "FCNetworkHelper.h"
#import <AFNetworking.h>

@implementation FCNetworkHelper

+ (instancetype)networkHelper {
    return [[self alloc] init];
}

- (void)networkRequest:(RequestType)requestType
             urlString:(NSString *)urlStr
                params:(NSDictionary *)params
                   tag:(NSInteger)tag {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    switch (requestType) {
            //get请求
        case RequestTypeGet: {
            [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                [self successWithResponseObject:responseObject atOperation:operation tag:tag];
            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                [self failureWithError:error atOperation:operation tag:tag];
            }];
        }
            break;
            
            //post请求
        case RequestTypePost: {
            [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                [self successWithResponseObject:responseObject atOperation:operation tag:tag];
            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                [self failureWithError:error atOperation:operation tag:tag];
            }];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark -- private methods
- (void)successWithResponseObject:(id)responseObject
                      atOperation:(AFHTTPRequestOperation *)operation
                              tag:(NSInteger)tag {
    if ([self.delegate respondsToSelector:@selector(networkHelperSuccessWithResponseObject:atOperation:tag:)]) {
        [self.delegate networkHelperSuccessWithResponseObject:responseObject atOperation:operation tag:tag];
    } else {
        NSAssert(1, @"没有实现network代理方法---networkHelperSucceed");
    }
}

- (void)failureWithError:(NSError *)error atOperation:(AFHTTPRequestOperation *)operation tag:(NSInteger)tag {
//    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络连接出错\n请检查网络连接" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//                                                          handler:^(UIAlertAction * action) {}];
//    
//    [alertV addAction:defaultAction];
    NSLog(@"网络连接出错\n请检查网络连接");
    if ([self.delegate respondsToSelector:@selector(networkHelperFailureWithResponseObject:atOperation:tag:)]) {
        [self.delegate networkHelperFailureWithResponseObject:error atOperation:operation tag:tag];
    } else {
        NSAssert(1, @"没有实现network代理方法---networkHelperFailed");
    }
}
@end
