//
//  UIWindow+TCHelper.m
//  TCKit
//
//  Created by dake on 15-7-29.
//  Copyright (c) 2015年 dake. All rights reserved.
//

#import "UIWindow+TCHelper.h"

@implementation UIWindow (TCHelper)

+ (UIViewController *)keyWindowTopController
{
    return [[UIApplication sharedApplication].keyWindow topMostViewController];
}


// code from: http://stackoverflow.com/questions/11637709/get-the-current-displaying-uiviewcontroller-on-the-screen-in-appdelegate-m
- (UIViewController *)topMostViewController
{
    for (UIView *subView in self.subviews) {
        UIResponder *responder = subView.nextResponder;
        
        // added this block of code for iOS 8 which puts a UITransitionView in between the UIWindow and the UILayoutContainerView
        if ([responder isEqual:self]) {
            // this is a UITransitionView
            if (subView.subviews.count > 0) {
                UIView *subSubView = subView.subviews.firstObject; // this should be the UILayoutContainerView
                responder = subSubView.nextResponder;
            }
        }
        
        if ([responder isKindOfClass:UIViewController.class]) {
            return [self topViewController:(UIViewController *)responder];
        }
    }
    
    return nil;
}

- (UIViewController *)topViewController:(UIViewController *)controller
{
    BOOL isPresenting = NO;
    do {
        // this path is called only on iOS 6+, so -presentedViewController is fine here.
        UIViewController *presented = controller.presentedViewController;
        isPresenting = presented != nil;
        if (presented != nil) {
            controller = presented;
        }
        
    } while (isPresenting);
    
    return controller;
}

#ifdef __IPHONE_7_0

- (UIViewController *)viewControllerForStatusBarStyle
{
    UIViewController *currentViewController = self.topMostViewController;
    while (nil != currentViewController.childViewControllerForStatusBarStyle) {
        currentViewController = currentViewController.childViewControllerForStatusBarStyle;
    }
    return currentViewController;
}

- (UIViewController *)viewControllerForStatusBarHidden
{
    UIViewController *currentViewController = self.topMostViewController;
    while (nil != currentViewController.childViewControllerForStatusBarHidden) {
        currentViewController = currentViewController.childViewControllerForStatusBarHidden;
    }
    return currentViewController;
}

#endif

@end
