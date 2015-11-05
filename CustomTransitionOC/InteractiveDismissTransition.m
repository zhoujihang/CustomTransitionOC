//
//  InteractiveDismissTransition.m
//  CustomTransitionOC
//
//  Created by 周际航 on 15/11/5.
//  Copyright © 2015年 zjh. All rights reserved.
//

#import "InteractiveDismissTransition.h"

@interface InteractiveDismissTransition()

@property (nonatomic, weak) UIViewController *dismissVC;
// 是否应该完成（超过50%）
@property (nonatomic, assign) BOOL shouldComplete;
// 移动的最长距离
@property (nonatomic, assign) CGFloat distance;

@end

@implementation InteractiveDismissTransition

- (instancetype)init{
    self = [super init];
    if (self){
        self.distance = [UIScreen mainScreen].bounds.size.height*0.5;
    }
    return self;
}

- (void)setDismissViewController:(UIViewController *)vc{
    self.dismissVC = vc;
    [self setPanGesture];
}

- (void)setPanGesture{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureHandle:)];
    [self.dismissVC.view addGestureRecognizer:pan];
}

- (void)panGestureHandle:(UIPanGestureRecognizer *)panGesture{
    // 再y轴上的移动距离
    CGFloat translationY = [panGesture translationInView:panGesture.view].y;
    
    switch (panGesture.state ) {
        case UIGestureRecognizerStateBegan: {
            // 开始移动
            self.isInteractive = YES;
            [self.dismissVC dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        case UIGestureRecognizerStateChanged:{
            // 状态改变
            CGFloat percentComplete = translationY/self.distance;
            percentComplete = fminf(fmaxf(percentComplete, 0.0),1.0);
            self.shouldComplete = percentComplete > 0.5;
            
            [self updateInteractiveTransition:percentComplete];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            // 移动结束
            self.isInteractive = NO;
            
            if (self.shouldComplete && panGesture.state==UIGestureRecognizerStateEnded) {
                // 完成dismiss
                [self finishInteractiveTransition];
            }else {
                // 取消dismiss
                [self cancelInteractiveTransition];
            }
            
            break;
        }
        default: {
            break;
        }
    }
}

@end
