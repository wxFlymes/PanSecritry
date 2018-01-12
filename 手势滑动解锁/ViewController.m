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

    [self makeSubviewInit];
    [self makeSubviewLayout];

}

- (void) makeSubviewInit
{
    self.avatorView = [[UIImageView alloc] init];
    self.avatorView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatorView.layer.cornerRadius = 40;
    self.avatorView.layer.masksToBounds = YES;
    self.avatorView.translatesAutoresizingMaskIntoConstraints = NO;
    //
    self.avatorView.backgroundColor = [UIColor purpleColor];

    self.tipLabel = [[UILabel alloc] init];
    self.tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.tipLabel.numberOfLines = 2;
    self.tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.tipLabel.font = [UIFont systemFontOfSize:13];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.textColor = [UIColor redColor];
    self.tipLabel.backgroundColor = [UIColor purpleColor];

    CGFloat dWidth = [UIScreen mainScreen].bounds.size.width;

    self.secritryView = [[WXPanSecritryView alloc] initWithFrame:CGRectMake(0, 260, dWidth, dWidth)];
    self.secritryView.wxDelegate = self;


    self.bottomBackView = [[UIView alloc] init];
    self.bottomBackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomBackView.backgroundColor = [UIColor purpleColor];

    self.pinkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pinkBtn setTitleColor:[UIColor colorWithRed:35/255.0 green:139/255.0 blue:203/255.0 alpha:1.0] forState:UIControlStateNormal];


    self.otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.otherBtn setTitleColor:[UIColor colorWithRed:35/255.0 green:139/255.0 blue:203/255.0 alpha:1.0] forState:UIControlStateNormal];

    self.seperateLine = [[UIView alloc] init];
    self.seperateLine.backgroundColor = [UIColor lightGrayColor];

    [self.view addSubview:self.avatorView];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.secritryView];

    [self.bottomBackView addSubview:self.pinkBtn];
    [self.bottomBackView addSubview:self.otherBtn];
    [self.bottomBackView addSubview:self.seperateLine];
    [self.view addSubview:self.bottomBackView];

}



- (void) makeSubviewLayout
{
    //
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.avatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.avatorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:100]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.avatorView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:80]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.avatorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:80]];





    //
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.avatorView attribute:NSLayoutAttributeBottom multiplier:1 constant:30]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30]];






    //
    //
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomBackView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.secritryView attribute:NSLayoutAttributeBottom multiplier:1 constant:20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomBackView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30]];





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
