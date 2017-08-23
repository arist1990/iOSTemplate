//
//  ZYHttpClient
//
//  Created by ZH_ZZ_MAC on 13-10-13.
//  Copyright (c) 2014年 ZZ. All rights reserved.
//

#import "HttpClient.h"
#import "AFNetworking.h"

@implementation HttpClient

static HttpClient *_instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    // 也可以使用一次性代码
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

// 为了使实例易于外界访问 我们一般提供一个类方法
// 类方法命名规范 share类名|default类名|类名
+ (instancetype)shareInstance {
    //return _instance;
    // 最好用self 用Tools他的子类调用时会出现错误
    return [[self alloc]init];
}

// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
+ (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

+ (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

//- (NSMutableArray *)tasks{
//    if (_tasks == nil) {
//        _tasks = [NSMutableArray new];
//    }
//    return _tasks;
//}

//- (void)cancel:(NSUInteger)taskIdentify{
//    NSNumber *identify = [NSNumber numberWithUnsignedInteger:taskIdentify];
//    [self.taskIdentifiers removeObject:identify];
//}

//- (void)cancelTask:(NSURLSessionTask *)task {
//    [task cancel];
//    [self.tasks removeObject:task];
//}

- (NSURLSessionTask *)getWithURL:(NSString *)urlString completeBlock:(RequestFinishBlock)block{
    
    NSLog(@"请求的url：%@", urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    request.timeoutInterval = 30;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = nil;
    task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
//        NSNumber *identify = [NSNumber numberWithUnsignedInteger:task.taskIdentifier];
        
//        if ([self.tasks containsObject:task]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error == nil) {
                    
                    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSDictionary *dic = [str objectFromJSONString];
                    
                    if (block) {
                        block(dic);
                    }
                    
                    NSLog(@"\n%@:\n%@", response.URL, dic);
                    
                }
            });
            
//            [self.tasks removeObject:task];
//        }
        
    }];
    
    [task resume];
    
//    [self.tasks addObject:task];
    
    return task;
    
}

- (NSURLSessionTask *)postWithURL:(NSString *)urlString httpBody:(NSString *)httpBody completeBlock:(RequestFinishBlock)block{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    request.timeoutInterval = 30;
    request.HTTPMethod = @"POST";
    request.HTTPBody = [httpBody dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = nil;
    task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
//        if ([self.tasks containsObject:task]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error == nil) {
                    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSDictionary *dic = [str objectFromJSONString];
                    
                    if (block) {
                        block(dic);
                    }
                    NSLog(@"\n%@:\n%@", response.URL, dic);
                    
                }
            });
            
//            [self.tasks removeObject:task];
//        }
        
        
    }];
    
    [task resume];
    
//    [self.tasks addObject:task];
    
    return task;
}

- (NSURLSessionTask *)postWithURL:(NSString *)urlString params:(NSMutableDictionary *)params completeBlock:(RequestFinishBlock)block{
    
    
    NSDictionary *userinfo = [NSUserDefaultTools getUserInfo];
    
    params = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSString *code = [userinfo objectForKey:@"Code"];
    if (code && code.length > 0) {
        [params setValue:code forKey:@"UserCode"];
    }
    
    // Add Headers
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:params error:NULL];
    
    NSLog(@"接口地址：%@\n传入参数：%@", urlString, params);
    
//    [request setValue:@"QkxPVkVfQUNDRVNTX1RPS0VOaHR0cDovL2FwaS5ibG92ZXMuY29tMDc1NTg2Mjg0NDA45qyi6L+O5L2/55SoQkxPVkXmjqXlj6PmnI3liqHmjojmnYPmiJDlip8=" forHTTPHeaderField:@"Access-Token"];
//    
//    NSString *SessionId = [userinfo objectForKey:@"SessionId"];
//    if (SessionId && SessionId.length > 0) {
//        [request setValue:SessionId forHTTPHeaderField:@"Access-SessionId"];
//    }
//    
//    NSLog(@"=====%@",request.allHTTPHeaderFields);
    
    
    request.timeoutInterval = 30;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = nil;
    task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
//        if ([self.tasks containsObject:task]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error == nil) {
                    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSDictionary *dic = [str objectFromJSONString];
                    
                    NSLog(@"\n%@:\n%@", response.URL, dic);
                    if (block) {
                        block(dic);
                    }
                    
                } else {
                    if (block) {
                        block(nil);
                    }
                }
            });
            
//            [self.tasks removeObject:task];
//        }
        
    }];
    
    [task resume];
    
//    [self.tasks addObject:task];
    
    return task;
    
}

@end







