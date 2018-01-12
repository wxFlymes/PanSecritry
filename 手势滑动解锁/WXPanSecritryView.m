//
//  WXPanSecritryView.m
//  手势滑动解锁
//
//  Created by Zhou on 2018/1/11.
//  Copyright © 2018年 WX. All rights reserved.
//

#import "WXPanSecritryView.h"

@interface WXPanSecritryView()

@property (nonatomic, strong) NSMutableArray<WXPanSecritryNode*>* statusArr;//记录状态
@property (nonatomic, strong) NSMutableArray<UIView*>* wxSubviewArr;
@property (nonatomic, strong) NSMutableArray<NSValue*>* wxSecPointArr;

@property (nonatomic, strong) CAShapeLayer* paintLayer;

@property (nonatomic) CGPoint startPoint;

@property (nonatomic) CGPoint endPoint;

@property (nonatomic) CGSize viewSize;


@property (nonatomic,strong) UIBezierPath* lineTotalPath;


@end

@implementation WXPanSecritryView


- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.viewSize = frame.size;
        self.startPoint = CGPointZero;
        self.endPoint = CGPointZero;

        self.wxLineWidth = 1;
        self.wxLineColor = [UIColor redColor];

        [self makeSatusInit];

        self.lineTotalPath = [UIBezierPath bezierPath];


        self.paintLayer = [CAShapeLayer layer];
        self.paintLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.paintLayer.backgroundColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:self.paintLayer];

        UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        pan.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:pan];

        [self makeSubviewInit];
    }
    return self;
}

//初始化状态
-(void) makeSatusInit
{
    for (int i = 0; i < 9; i++) {
        WXPanSecritryNode* node = [[WXPanSecritryNode alloc] init];
        node.wxNodeResult = NO;
        node.wxNodeIndex = 0;
        [self.statusArr addObject:node];
    }
}
//初始化子视图
- (void) makeSubviewInit
{
    CGFloat itemWidth = 50;
    CGFloat itemHeight = 50;
    CGFloat edgeSpace = 30;
    CGFloat topSpace = (self.viewSize.height - (self.viewSize.width-edgeSpace*2))/2.0;
    CGFloat space = (self.viewSize.width - itemWidth*3 - edgeSpace*2)/2.0;

    for (int i = 0; i < 9; i++) {
        //根据序号计算视图所在的行列位置
        NSInteger row = i/3;//行
        NSInteger line = i%3;//列

        UIView* wxView = [[UIView alloc] initWithFrame:CGRectMake(edgeSpace + line*(itemWidth+space), topSpace + row*(itemHeight+space), itemWidth, itemHeight)];
        wxView.layer.borderWidth = 1;
        wxView.layer.borderColor = [UIColor grayColor].CGColor;
        wxView.layer.cornerRadius = 25;
        wxView.layer.masksToBounds = YES;
        [self addSubview:wxView];
        [self.wxSubviewArr addObject:wxView];
    }

}
//还原初始化数据
- (void) resetInitStatus
{
    for (WXPanSecritryNode* node in self.statusArr) {
        node.wxNodeIndex = 0;
        node.wxNodeResult = NO;
    }
    for (UIView* wxView in self.wxSubviewArr) {
        wxView.backgroundColor = [UIColor whiteColor];
    }

    [self.wxSecPointArr removeAllObjects];
    self.startPoint = CGPointZero;
    self.endPoint = CGPointZero;

    [self.lineTotalPath removeAllPoints];
    self.paintLayer.path = self.lineTotalPath.CGPath;
    self.paintLayer.strokeColor = nil;
    self.paintLayer.fillColor = nil;
}

//响应滑动手势
- (void)panAction:(UIPanGestureRecognizer*)pan
{
    //获取手势所在位置
    CGPoint currentPoint = [pan locationInView:self];
    self.endPoint = currentPoint;


    __weak typeof(self) weakself = self;
    [self.wxSubviewArr enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakself) strongself = weakself;
        if ([strongself.statusArr objectAtIndex:idx].wxNodeResult) {

        }
        else{
            if (CGRectContainsPoint(obj.frame, currentPoint)) {

                obj.backgroundColor = [UIColor redColor];

                WXPanSecritryNode* currentNode = [strongself.statusArr objectAtIndex:idx];
                currentNode.wxNodeResult = YES;
                currentNode.wxNodeIndex = strongself.wxSecPointArr.count+1;

                
                if (CGPointEqualToPoint(strongself.startPoint, CGPointZero)) {
                    strongself.startPoint = CGPointMake(obj.frame.origin.x+obj.frame.size.width/2.0, obj.frame.origin.y+obj.frame.size.height/2.0);
                    [strongself.wxSecPointArr addObject:[NSValue valueWithCGPoint:strongself.startPoint]];
                }
                else{
                    CGPoint gapPoint = CGPointMake(obj.frame.origin.x+obj.frame.size.width/2.0, obj.frame.origin.y+obj.frame.size.height/2.0);
                    [strongself.wxSecPointArr addObject:[NSValue valueWithCGPoint:gapPoint]];
                }
            }
        }

    }];
    if (!CGPointEqualToPoint(self.endPoint, CGPointZero) && !CGPointEqualToPoint(self.startPoint, CGPointZero)) {
        //进行线条的绘制
        [self wxDrawLine];
    }


    if (pan.state == UIGestureRecognizerStateEnded) {
        //结束拖动时，先确定最后结束的点
        if (self.wxSecPointArr.count>0) {
            self.endPoint = [self.wxSecPointArr lastObject].CGPointValue;
        }
        else{
            self.endPoint = CGPointZero;
        }
        //当滑动手势结束的时候，获取到手势的结果，然后根据手势的结果执行响应的操作
        if (self.wxDelegate && [self.wxDelegate respondsToSelector:@selector(secritryView:didEndPanWithResult:)]) {
            [self.wxDelegate secritryView:self didEndPanWithResult:self.statusArr];
        }
        //执行回调之后，将数据状态初始化
        [self resetInitStatus];
    }

}
#pragma mark --- lazy
-(NSMutableArray*)statusArr
{
    if (!_statusArr) {
        _statusArr = [[NSMutableArray alloc] initWithCapacity:9];
    }
    return _statusArr;
}

- (NSMutableArray *)wxSubviewArr
{
    if (!_wxSubviewArr) {
        _wxSubviewArr = [[NSMutableArray alloc] initWithCapacity:9];
    }
    return _wxSubviewArr;
}
-(NSMutableArray<NSValue *> *)wxSecPointArr
{
    if (!_wxSecPointArr) {
        _wxSecPointArr = [[NSMutableArray alloc] initWithCapacity:9];
    }
    return _wxSecPointArr;
}

#pragma mark ---
-(void)wxDrawLine
{
    [self.lineTotalPath removeAllPoints];
    [self.lineTotalPath moveToPoint:self.startPoint];
    if (self.wxSecPointArr.count>1) {
        __weak typeof(self) weakself = self;
        [self.wxSecPointArr enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            __strong typeof(weakself) strongself = weakself;
            if (idx>0) {
                CGPoint wxPoint = [obj CGPointValue];
                [strongself.lineTotalPath addLineToPoint:wxPoint];
            }
        }];
    }
    [self.lineTotalPath addLineToPoint:self.endPoint];
    self.lineTotalPath.lineWidth = self.wxLineWidth;

    self.paintLayer.path = self.lineTotalPath.CGPath;
    self.paintLayer.strokeColor = self.wxLineColor.CGColor;
    self.paintLayer.fillColor = nil;
}

@end



#pragma mark --- WXPanSecritryNode

@implementation WXPanSecritryNode


@end



