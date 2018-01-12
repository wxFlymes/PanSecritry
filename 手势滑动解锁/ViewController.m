//
//  ViewController.m
//  手势滑动解锁
//
//  Created by Zhou on 2018/1/11.
//  Copyright © 2018年 WX. All rights reserved.
//

#import "ViewController.h"
#import "WXPanSecritryView.h"

@interface ViewController ()<WXPanSecritryViewDelegate>

@property (nonatomic,strong) UIImageView* avatorView;
@property (nonatomic,strong) UILabel* tipLabel;

@property (nonatomic,strong) WXPanSecritryView* secritryView;

@property (nonatomic,strong) UIView* bottomBackView;
@property (nonatomic,strong) UIButton* pinkBtn;
@property (nonatomic,strong) UIView* seperateLine;
@property (nonatomic,strong) UIButton* otherBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.view.backgroundColor = [UIColor whiteColor];

    CGFloat dWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat dHeight = [UIScreen mainScreen].bounds.size.height;

    WXPanSecritryView* secView = [[WXPanSecritryView alloc] initWithFrame:CGRectMake(0, 64, dWidth, dHeight-64)];
    secView.wxDelegate = self;
    [self.view addSubview:secView];





}

- (void) makeSubviewInit
{
    self.avatorView = [[UIImageView alloc] init];
    self.tipLabel = [[UILabel alloc] init];
    self.tipLabel.numberOfLines = 2;
    self.tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.tipLabel.font = [UIFont systemFontOfSize:13];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.textColor = [UIColor redColor];

    CGFloat dWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat dHeight = [UIScreen mainScreen].bounds.size.height;

    self.secritryView = [[WXPanSecritryView alloc] initWithFrame:CGRectMake(0, 64, dWidth, dHeight-64)];


    self.bottomBackView = [[UIView alloc] init];
    self.bottomBackView.backgroundColor = [UIColor clearColor];

    self.pinkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pinkBtn setTitleColor:[UIColor colorWithRed:35/255.0 green:139/255.0 blue:203/255.0 alpha:1.0] forState:UIControlStateNormal];

}

- (void)secritryView:(WXPanSecritryView*)secrityView didEndPanWithResult:(NSArray<WXPanSecritryNode*>*)results
{
    NSLog(@"%@",results);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
