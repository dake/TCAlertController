//  UIActionSheet+Blocks.h
//  TCKit
//
//  Created by dake on 15/3/12.
//  Copyright (c) 2015年 Dake. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCAlertAction;
@interface UIActionSheet (Blocks) <UIActionSheetDelegate>

- (instancetype)initWithTitle:(NSString *)title cancelAction:(TCAlertAction *)cancelAction destructiveAction:(TCAlertAction *)destructiveAction otherActions:(TCAlertAction *)otherAction arguments:(va_list)argList;

- (instancetype)initWithTitle:(NSString *)title cancelAction:(TCAlertAction *)cancelAction destructiveAction:(TCAlertAction *)destructiveAction otherActions:(TCAlertAction *)otherAction, ... NS_REQUIRES_NIL_TERMINATION;

- (NSInteger)addAction:(TCAlertAction *)action;

/** This block is called when the action sheet is dismssed for any reason.
 */
@property (copy, nonatomic) void(^dismissalAction)();

@end
