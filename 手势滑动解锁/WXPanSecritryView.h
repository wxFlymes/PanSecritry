//
//  WXPanSecritryView.h
//  手势滑动解锁
//
//  Created by Zhou on 2018/1/11.
//  Copyright © 2018年 WX. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WXPanSecritryView,WXPanSecritryNode;
@protocol WXPanSecritryViewDelegate<NSObject>
@optional
/***/
- (void)secritryView:(WXPanSecritryView*)secrityView didEndPanWithResult:(NSArray<WXPanSecritryNode*>*)results;

@end


@interface WXPanSecritryView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, weak) id<WXPanSecritryViewDelegate> wxDelegate;

@property (nonatomic, strong) UIColor* wxLineColor;

@property (nonatomic) CGFloat wxLineWidth;

@property (nonatomic, strong) UIImage* wxNormalImg;

@property (nonatomic, strong) UIImage* wxSelectImg;

@end



//代表手势选中的点
@interface WXPanSecritryNode : NSObject

/**
 *  点的选中状态
 */
@property (nonatomic) BOOL wxNodeResult;
/**
 *  选中点的索引
 */
@property (nonatomic) NSInteger wxNodeIndex;



@end


