//
//  ViewController.m
//  CustomTransitionOC
//
//  Created by 周际航 on 15/11/5.
//  Copyright © 2015年 zjh. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"

#import "CustomModalTransition.h"
#import "CustomDismissTransition.h"

#import "InteractiveDismissTransition.h"
@interface ViewController ()<ModalViewControllerDelegate, UIViewControllerTransitioningDelegate>
// modal动画代理
@property (nonatomic, strong) CustomModalTransition *modalTransition;
// dismiss动画代理
@property (nonatomic, strong) CustomDismissTransition *dismissTransition;
// 交互式dismiss动画代理
@property (nonatomic, strong) InteractiveDismissTransition *interactiveDismissTransition;
@end

//static NSInteger count = 0;
@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.modalTransition = [[CustomModalTransition alloc]init];
        self.dismissTransition = [[CustomDismissTransition alloc]init];
        self.interactiveDismissTransition = [[InteractiveDismissTransition alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat r = (arc4random_uniform(100)+155)/255.0;
    CGFloat g = (arc4random_uniform(100)+155)/255.0;
    CGFloat b = (arc4random_uniform(100)+155)/255.0;

    self.view.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
    
}
// modal出新的控制器
- (IBAction)modalBtnClicked:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ModalViewController *toVC = [sb instantiateViewControllerWithIdentifier:@"ModalViewController"];
    toVC.delegate = self;
    toVC.transitioningDelegate = self;
    [self.interactiveDismissTransition setDismissViewController:toVC];
    [self presentViewController:toVC animated:YES completion:nil];
}

#pragma mark - modal dismiss代理
- (void)modalViewControllerClickedDismissBtn:(ModalViewController *)modalVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 转场代理
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.modalTransition;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.dismissTransition;
}
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.interactiveDismissTransition.isInteractive ? self.interactiveDismissTransition : nil;
}

@end
