//
//  UIWindow+TCHelper.h
//  SudiyiClient
//
//  Created by dake on 15-7-29.
//  Copyright (c) 2015年 Dake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (TCHelper)

- (UIViewController *)topMostViewController;

#ifdef __IPHONE_7_0
- (UIViewController *)viewControllerForStatusBarStyle;
- (UIViewController *)viewControllerForStatusBarHidden;
#endif

@end
