//
//  DemoTableViewController.m
//  HDRequestTools
//
//  Created by hundredlee on 8/1/16.
//  Copyright © 2016 HundredLee. All rights reserved.
//

#import "DemoTableViewController.h"
#import "DemoViewModel.h"
#import "DemoModel.h"

@interface DemoTableViewController ()
@property (nonatomic,retain) UILabel *info;
@property (nonatomic,strong) DemoViewModel *demoViewModel;
@end

@implementation DemoTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.info = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    [self.info setText:@"xxxx"];
    [self.info setFont:[UIFont systemFontOfSize:17]];
    [self.info setTextColor:[UIColor redColor]];
    [self.view addSubview:self.info];
    
    self.demoViewModel = [[DemoViewModel alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.demoViewModel demoRequest];
    
    
    __weak typeof (self) weakSelf = self;
    self.demoViewModel.successReturn = ^(){
        
        DemoModel *model = weakSelf.demoViewModel.demoModel;
        
        weakSelf.info.text = [NSString stringWithFormat:@"%@---%@----%@",model.username,model.telphone,model.address];
        
    };
}

@end
