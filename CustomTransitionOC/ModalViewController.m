//
//  ModalViewController.m
//  CustomTransitionOC
//
//  Created by 周际航 on 15/11/5.
//  Copyright © 2015年 zjh. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)dismissBtnClicked:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(modalViewControllerClickedDismissBtn:)]) {
        [self.delegate modalViewControllerClickedDismissBtn:self];
    }
}

@end
