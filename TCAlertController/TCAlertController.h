//
//  TCAlertController.h
//  TCKit
//
//  Created by dake on 15/3/12.
//  Copyright (c) 2015年 dake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCAlertAction.h"


typedef NS_ENUM(NSInteger, TCAlertControllerStyle) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    kTCAlertControllerStyleActionSheet = UIAlertControllerStyleActionSheet,
    kTCAlertControllerStyleAlert = UIAlertControllerStyleAlert,
#else
    kTCAlertControllerStyleActionSheet = 0,
    kTCAlertControllerStyleAlert,
#endif
};


@interface TCAlertController : NSObject

@property (nonatomic, assign) TCAlertControllerStyle preferredStyle;

- (instancetype)initAlertViewWithTitle:(NSString *)title
                               message:(NSString *)message
                         presentCtrler:(UIViewController *)viewCtrler
                          cancelAction:(TCAlertAction *)cancelAction
                           otherAction:(TCAlertAction *)otherAction, ... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initActionSheetWithTitle:(NSString *)title
                           presentCtrler:(UIViewController *)viewCtrler
                            cancelAction:(TCAlertAction *)cancelAction
                       destructiveAction:(TCAlertAction *)destructiveAction
                             otherAction:(TCAlertAction *)otherAction, ... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initAlertViewWithTitle:(NSString *)title
                               message:(NSString *)message
                         presentCtrler:(UIViewController *)viewCtrler
                          cancelAction:(TCAlertAction *)cancelAction
                          otherActions:(NSArray *)otherActions;

- (instancetype)initActionSheetWithTitle:(NSString *)title
                           presentCtrler:(UIViewController *)viewCtrler
                            cancelAction:(TCAlertAction *)cancelAction
                       destructiveAction:(TCAlertAction *)destructiveAction
                            otherActions:(NSArray *)otherActions;

- (void)addAction:(TCAlertAction *)action;
- (void)show;

@end
