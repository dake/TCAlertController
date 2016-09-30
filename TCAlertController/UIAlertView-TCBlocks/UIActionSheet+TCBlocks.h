//  UIActionSheet+TCBlocks.h
//  TCKit
//
//  Created by dake on 15/3/12.
//  Copyright (c) 2015年 dake. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0

@class TCAlertAction;
@interface UIActionSheet (TCBlocks)

- (instancetype)initWithTitle:(NSString *)title cancelAction:(TCAlertAction *)cancelAction destructiveAction:(TCAlertAction *)destructiveAction otherActions:(NSArray<TCAlertAction *> *)otherActions;
- (instancetype)initWithTitle:(NSString *)title cancelAction:(TCAlertAction *)cancelAction destructiveAction:(TCAlertAction *)destructiveAction otherAction:(TCAlertAction *)otherAction, ... NS_REQUIRES_NIL_TERMINATION;

- (void)addAction:(TCAlertAction *)action;

/** This block is called when the action sheet is dismssed for any reason.
 */
@property (nonatomic, copy) dispatch_block_t dismissalAction;

@end

#endif
