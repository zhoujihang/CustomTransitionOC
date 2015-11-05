//
//  ModalViewController.h
//  CustomTransitionOC
//
//  Created by 周际航 on 15/11/5.
//  Copyright © 2015年 zjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModalViewController;

@protocol ModalViewControllerDelegate <NSObject>

- (void)modalViewControllerClickedDismissBtn:(ModalViewController *) modalVC;

@end


@interface ModalViewController : UIViewController

@property (nonatomic, weak) id<ModalViewControllerDelegate> delegate;

@end
