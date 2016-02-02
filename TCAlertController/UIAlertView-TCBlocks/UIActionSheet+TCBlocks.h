//  UIActionSheet+TCBlocks.h
//  TCKit
//
//  Created by dake on 15/3/12.
//  Copyright (c) 2015年 dake. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCAlertAction;
@interface UIActionSheet (TCBlocks)

- (instancetype)initWithTitle:(NSString *)title cancelAction:(TCAlertAction *)cancelAction destructiveAction:(TCAlertAction *)destructiveAction otherActions:(NSArray<TCAlertAction *> *)otherActions;
- (instancetype)initWithTitle:(NSString *)title cancelAction:(TCAlertAction *)cancelAction destructiveAction:(TCAlertAction *)destructiveAction otherAction:(TCAlertAction *)otherAction, ... NS_REQUIRES_NIL_TERMINATION;

- (NSInteger)addAction:(TCAlertAction *)action;

/** This block is called when the action sheet is dismssed for any reason.
 */
@property (nonatomic, copy) dispatch_block_t dismissalAction;

@end
