//
//  InteractiveDismissTransition.h
//  CustomTransitionOC
//
//  Created by 周际航 on 15/11/5.
//  Copyright © 2015年 zjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InteractiveDismissTransition : UIPercentDrivenInteractiveTransition

// 设置执行dismiss的控制器
- (void)setDismissViewController:(UIViewController *)vc;

// 当前是否接受dismiss交互
@property (nonatomic, assign) BOOL isInteractive;

@end
