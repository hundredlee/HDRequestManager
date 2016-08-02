//
//  DemoViewModel.h
//  HDRequestTools
//
//  Created by hundredlee on 8/1/16.
//  Copyright © 2016 HundredLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoModel.h"

@interface DemoViewModel : NSObject

@property (nonatomic,assign) NSInteger status;
@property (nonatomic,strong) DemoModel *demoModel;

@property (nonatomic,copy) void(^successReturn)();

- (void) demoRequest;
@end
