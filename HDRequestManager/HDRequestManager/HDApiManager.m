//
//  HDApiManager.m
//  EasyPay
//
//  Created by hundredlee on 7/15/16.
//  Copyright © 2016 HundredLee. All rights reserved.
//

#import "HDApiManager.h"
#import "AFNetWorking.h"

static NSMutableDictionary *apiConfigures;
static AFHTTPSessionManager *manager = nil;

@implementation HDApiManager


+ (void)initialize
{
    manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    manager.requestSerializer.HTTPShouldHandleCookies=YES;
    apiConfigures = [[NSMutableDictionary alloc] init];
}

- (instancetype) initWithConfigure:(HDApiConfigure *)configure
{
    if (self = [super init]) {
        _apiConfigure = configure;
    }
    return self;
}



+ (HDApiManager *) createApiConfigure:(NSString *)apiName
{
    HDApiManager *manager = [[HDApiManager alloc] initWithConfigure:apiConfigures[apiName]];
    return manager;
}


+ (void) addConfigure:(HDApiConfigure *)configure withApiKey:(NSString *)apiKey
{
    apiConfigures[apiKey] = configure;
}


- (void) requestWithParams:(NSDictionary *)params
{
    //请求所有的api时，先读取cookie
    [self readCookie];
    
    
    NSMutableDictionary *newParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    if (self.apiConfigure.beforeRequest) {
        self.apiConfigure.beforeRequest(params);
    }
    
    if (self.apiConfigure.defaultParams) {
        [newParams addEntriesFromDictionary:self.apiConfigure.defaultParams];
    }
    
    
    if (self.apiConfigure.requestMethod == HDREQUEST_METHOD_POST) {
        
        [manager POST:self.apiConfigure.url parameters:newParams progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (self.apiConfigure.afterRequest) {
                self.apiConfigure.afterRequest(responseObject);
            }
            
            if (self.apiConfigure.statusProcessor) {
                self.apiConfigure.statusProcessor(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            

            
        }];
    }else if(self.apiConfigure.requestMethod == HDREQUEST_METHOD_GET){
        
        [manager GET:self.apiConfigure.url parameters:newParams progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (self.apiConfigure.afterRequest) {
                self.apiConfigure.afterRequest(responseObject);
            }
            
            if (self.apiConfigure.statusProcessor) {
                self.apiConfigure.statusProcessor(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
            
        }];
    
    }else if(self.apiConfigure.requestMethod == HDREQUEST_METHOD_PUT){
        
        [manager PUT:self.apiConfigure.url parameters:newParams progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (self.apiConfigure.afterRequest) {
                self.apiConfigure.afterRequest(responseObject);
            }
            
            if (self.apiConfigure.statusProcessor) {
                self.apiConfigure.statusProcessor(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
            
        }];
        
    }
    
    //you can add other request methods here
    
    
}


+ (void)saveCookie
{
    NSMutableArray *cookieArray = [[NSMutableArray alloc] init];
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        [cookieArray addObject:cookie.name];
        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
        [cookieProperties setObject:cookie.name forKey:NSHTTPCookieName];
        [cookieProperties setObject:cookie.value forKey:NSHTTPCookieValue];
        [cookieProperties setObject:cookie.domain forKey:NSHTTPCookieDomain];
        [cookieProperties setObject:cookie.path forKey:NSHTTPCookiePath];
        [cookieProperties setObject:[NSString stringWithFormat:@"%lu",(unsigned long)cookie.version ] forKey:NSHTTPCookieVersion];
        [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
        [[NSUserDefaults standardUserDefaults] setValue:cookieProperties forKey:cookie.name];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [[NSUserDefaults standardUserDefaults] setValue:cookieArray forKey:@"cookie"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//read the cookie when you login status
- (void)readCookie
{
    NSMutableArray* cookieDictionary = [[NSUserDefaults standardUserDefaults] valueForKey:@"cookie"];
    for (int i=0; i < cookieDictionary.count; i++)
    {
        NSMutableDictionary* cookieDictionary1 = [[NSUserDefaults standardUserDefaults] valueForKey:[cookieDictionary objectAtIndex:i]];
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieDictionary1];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
}

@end
