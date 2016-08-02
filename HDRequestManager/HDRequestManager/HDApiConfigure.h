//
//  HDApiConfigure.h
//  EasyPay
//
//  Created by hundredlee on 7/15/16.
//  Copyright © 2016 HundredLee. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface HDApiConfigure : NSObject

typedef NS_ENUM(NSInteger,HDRequestMethod){
    HDREQUEST_METHOD_POST,
    HDREQUEST_METHOD_GET,
    HDREQUEST_METHOD_PUT,
    HDREQUEST_METHOD_PATCH,
    HDREQUEST_METHOD_DELETE
};


@property (nonatomic,copy) NSString *url;
@property (nonatomic,strong) NSDictionary *defaultParams;

@property (nonatomic,assign) HDRequestMethod requestMethod;

@property (nonatomic,copy) void(^beforeRequest)(NSDictionary *params);
@property (nonatomic,copy) void(^afterRequest)(id result);
@property (nonatomic,copy) void(^statusProcessor)(id result);


@end
