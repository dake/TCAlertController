//  UIActionSheet+TCBlocks.m
//  TCKit
//
//  Created by dake on 15/3/12.
//  Copyright (c) 2015年 dake. All rights reserved.
//

#import "UIActionSheet+TCBlocks.h"
#import <objc/runtime.h>
#import "TCAlertAction.h"
#import "TCAlertViewDelegate.h"


static char const kRI_BUTTON_ASS_KEY;
static char const kRI_DISMISSAL_ACTION_KEY;

@implementation UIActionSheet (TCBlocks)

- (dispatch_block_t)dismissalAction
{
    return objc_getAssociatedObject(self, &kRI_DISMISSAL_ACTION_KEY);
}

- (void)setDismissalAction:(dispatch_block_t)dismissalAction
{
    objc_setAssociatedObject(self, &kRI_DISMISSAL_ACTION_KEY, dismissalAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSMutableArray<TCAlertAction *> *)buttonItems
{
    return objc_getAssociatedObject(self, &kRI_BUTTON_ASS_KEY);
}

- (void)setButtonItems:(NSMutableArray<TCAlertAction *> *)items
{
    objc_setAssociatedObject(self, &kRI_BUTTON_ASS_KEY, items, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TCAlertViewDelegate *)tc_innerDelegate
{
    TCAlertViewDelegate *obj = objc_getAssociatedObject(self, _cmd);
    if (nil == obj) {
        obj = [[TCAlertViewDelegate alloc] init];
        objc_setAssociatedObject(self, _cmd, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return obj;
}


- (instancetype)initWithTitle:(NSString *)title cancelAction:(TCAlertAction *)cancelAction destructiveAction:(TCAlertAction *)destructiveAction otherActions:(NSArray<TCAlertAction *> *)otherActions
{
    if (self) {
        self = [self initWithTitle:title delegate:nil cancelButtonTitle:nil destructiveButtonTitle:destructiveAction.title otherButtonTitles:nil];
        
        self.delegate = self.tc_innerDelegate;
        NSMutableArray *buttonsArray = [NSMutableArray array];
        if (nil != destructiveAction) {
            [buttonsArray addObject:destructiveAction];
        }
        
        for (TCAlertAction *eachItem in otherActions) {
            [buttonsArray addObject:eachItem];
            [self addButtonWithTitle:eachItem.title];
        }
        
        if (nil != cancelAction) {
            [buttonsArray addObject:cancelAction];
            [self addButtonWithTitle:cancelAction.title];
            self.cancelButtonIndex = [buttonsArray indexOfObject:cancelAction];
        }
        
        self.buttonItems = buttonsArray;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title cancelAction:(TCAlertAction *)cancelAction destructiveAction:(TCAlertAction *)destructiveAction otherAction:(TCAlertAction *)otherAction, ...
{
    NSMutableArray *arry = nil;
    if (nil != otherAction) {
        arry = [NSMutableArray array];
        TCAlertAction *eachItem = otherAction;
        va_list argList;
        va_start(argList, otherAction);
        do {
            [arry addObject:eachItem];
            eachItem = va_arg(argList, TCAlertAction *);
        } while (nil != eachItem);
        va_end(argList);
    }
    
    return [self initWithTitle:title cancelAction:cancelAction destructiveAction:destructiveAction otherActions:arry];
}


- (NSInteger)addAction:(TCAlertAction *)action
{
    if (nil == action) {
        return NSNotFound;
    }
    
    if (nil == self.delegate) {
        self.delegate = self.tc_innerDelegate;
    }
    
    [self.buttonItems addObject:action];
    return [self addButtonWithTitle:action.title];
}

@end

