//
//  ViewController.m
//  UMFeedback
//
//  Created by 郭达 on 15/5/7.
//  Copyright (c) 2015年 guoda. All rights reserved.
//

#import "ViewController.h"
#import "UMFeedback.h"
#import "CustomViewController.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //用户反馈
    UIButton *feedbackBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    feedbackBtn.frame = CGRectMake(100, 100, 100, 30);
    feedbackBtn.backgroundColor = [UIColor yellowColor];
    feedbackBtn.layer.cornerRadius = 8;
    feedbackBtn.clipsToBounds = YES;
    [self.view addSubview:feedbackBtn];
    [feedbackBtn setTitle:@"用户反馈" forState:UIControlStateNormal];
    [feedbackBtn addTarget:self action:@selector(feedbackBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //自定义
    [self createByMyself];

}
-(void)createByMyself
{
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    customBtn.frame = CGRectMake(100, 200, 100, 30);
    customBtn.backgroundColor = [UIColor yellowColor];
    customBtn.layer.cornerRadius = 8;
    customBtn.clipsToBounds = YES;
    [self.view addSubview:customBtn];
    [customBtn setTitle:@"自定义" forState:UIControlStateNormal];
    [customBtn addTarget:self action:@selector(customBtn:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)customBtn:(UIButton *)btn
{
    CustomViewController *custom = [[CustomViewController alloc] init];
    [self presentViewController:custom animated:YES completion:nil];
    
}
#pragma mark - 友盟用户反馈
-(void)feedbackBtn:(UIButton *)btn
{
    [self presentViewController:[UMFeedback feedbackModalViewController] animated:YES completion:nil];

    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
