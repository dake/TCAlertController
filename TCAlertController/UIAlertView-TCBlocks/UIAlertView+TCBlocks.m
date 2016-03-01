//
//  UIAlertView+TCBlocks.m
//  TCKit
//
//  Created by dake on 15/3/12.
//  Copyright (c) 2015年 dake. All rights reserved.
//

#import "UIAlertView+TCBlocks.h"
#import <objc/runtime.h>
#import "TCAlertAction.h"
#import "TCAlertViewDelegate.h"


static char const kRI_BUTTON_ASS_KEY;

@implementation UIAlertView (TCBlocks)

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


- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelAction:(TCAlertAction *)cancelAction otherActions:(NSArray<TCAlertAction *> *)otherActions
{
    if (self) {
        self = [self initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelAction.title otherButtonTitles:nil];
        self.delegate = self.tc_innerDelegate;
        
        NSMutableArray *buttonsArray = [NSMutableArray array];
        if (nil != cancelAction) {
            [buttonsArray addObject:cancelAction];
        }
        
        for (TCAlertAction *eachItem in otherActions) {
            [buttonsArray addObject:eachItem];
            [self addButtonWithTitle:eachItem.title];
        }
        
        self.buttonItems = buttonsArray;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelAction:(TCAlertAction *)cancelAction otherAction:(TCAlertAction *)otherAction, ...
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
    
    return [self initWithTitle:title message:message cancelAction:cancelAction otherActions:arry];
}

- (void)addAction:(TCAlertAction *)action
{
    if (nil == action) {
        return;
    }
    
    if (nil == self.delegate) {
        self.delegate = self.tc_innerDelegate;
    }
    
    [self.buttonItems addObject:action];
    [self addButtonWithTitle:action.title];
}

@end
