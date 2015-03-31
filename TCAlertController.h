//
//  TCAlertController.h
//  TCKit
//
//  Created by dake on 15/3/12.
//  Copyright (c) 2015年 Dake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCAlertAction.h"

@interface TCAlertController : NSObject

- (instancetype)initAlertViewWithTitle:(NSString *)title
                               message:(NSString *)message
                         presentCtrler:(UIViewController *)viewCtrler
                          cancelAction:(TCAlertAction *)cancelAction
                           otherAction:(TCAlertAction *)otherAction, ... NS_REQUIRES_NIL_TERMINATION __attribute__((nonnull (3)));

- (instancetype)initActionSheetWithTitle:(NSString *)title
                           presentCtrler:(UIViewController *)viewCtrler
                            cancelAction:(TCAlertAction *)cancelAction
                       destructiveAction:(TCAlertAction *)destructiveAction
                             otherAction:(TCAlertAction *)otherAction, ... NS_REQUIRES_NIL_TERMINATION __attribute__((nonnull (2)));

- (void)addAction:(TCAlertAction *)action;
- (void)show;

@end
