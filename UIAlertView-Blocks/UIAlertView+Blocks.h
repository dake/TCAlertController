//
//  UIAlertView+Blocks.h
//  TCKit
//
//  Created by dake on 15/3/12.
//  Copyright (c) 2015年 Dake. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCAlertAction;
@interface UIAlertView (Blocks)

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelAction:(TCAlertAction *)cancelAction otherActions:(TCAlertAction *)otherAction arguments:(va_list)argList;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelAction:(TCAlertAction *)cancelAction otherActions:(TCAlertAction *)otherAction, ... NS_REQUIRES_NIL_TERMINATION;

- (NSInteger)addAction:(TCAlertAction *)action;

@end
