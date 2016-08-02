//
//  HDApiManager.h
//  EasyPay
//
//  Created by hundredlee on 7/15/16.
//  Copyright © 2016 HundredLee. All rights reserved.
//


#import "HDApiConfigure.h"

@class HDApiConfigure;

@interface HDApiManager : NSObject

+ (HDApiManager *) createApiConfigure:(NSString *)apiName;
+ (void) addConfigure:(HDApiConfigure *)configure withApiKey:(NSString *)apiKey;
- (void) requestWithParams:(NSDictionary *)params;
+ (void) saveCookie;

@property (nonatomic,strong) HDApiConfigure *apiConfigure;

@end
