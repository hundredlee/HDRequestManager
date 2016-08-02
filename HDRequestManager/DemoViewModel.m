//
//  DemoViewModel.m
//  HDRequestTools
//
//  Created by hundredlee on 8/1/16.
//  Copyright © 2016 HundredLee. All rights reserved.
//

#import "DemoViewModel.h"
#import "HDRequestManager/HDRequestConfig.h"

@implementation DemoViewModel

- (instancetype)init
{
    if (self = [super init]) {
        
        HDApiConfigure *apiConfigure = [[HDApiConfigure alloc] init];
        apiConfigure.requestMethod = HDREQUEST_METHOD_POST;
        apiConfigure.url = @"http://blog.sodroid.com/demo/api.php";
        apiConfigure.afterRequest = ^(id responseData){
            
            self.status = [responseData[@"status"] integerValue];
            if (self.status == 200) {
                self.demoModel = [[DemoModel alloc] init];
                [self.demoModel setUsername:responseData[@"username"]];
                [self.demoModel setAddress:responseData[@"address"]];
                [self.demoModel setTelphone:responseData[@"telphone"]];
            }
            
            if (self.successReturn) {
                self.successReturn();
            }
        };
        [HDApiManager addConfigure:apiConfigure withApiKey:@"demoApi"];
    }
    return self;
}

- (void)demoRequest
{
    NSDictionary *param = @{@"username":@"hundredlee"};
    HDApiManager *apiManager = [HDApiManager createApiConfigure:@"demoApi"];
    [apiManager requestWithParams:param];
}

@end
