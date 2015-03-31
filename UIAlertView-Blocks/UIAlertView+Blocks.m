//
//  UIAlertView+Blocks.m
//  TCKit
//
//  Created by dake on 15/3/12.
//  Copyright (c) 2015年 Dake. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>
#import "TCAlertAction.h"

static char const kRI_BUTTON_ASS_KEY;

@implementation UIAlertView (Blocks)

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelAction:(TCAlertAction *)cancelAction otherActions:(TCAlertAction *)otherAction arguments:(va_list)argList
{
    if ((self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelAction.title otherButtonTitles:nil])) {
        NSMutableArray *buttonsArray = [self buttonItems];
        if (nil != cancelAction) {
            [buttonsArray addObject:cancelAction];
        }
        
        if (nil != otherAction) {
            TCAlertAction *eachItem = otherAction;
            do {
                [buttonsArray addObject:eachItem];
                [self addButtonWithTitle:eachItem.title];
                eachItem = va_arg(argList, TCAlertAction *);
            } while (nil != eachItem);
        }
        
        [self setDelegate:self];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelAction:(TCAlertAction *)cancelAction otherActions:(TCAlertAction *)otherAction, ...
{
    va_list argList;
    va_start(argList, otherAction);
    self = [self initWithTitle:title message:message cancelAction:cancelAction otherActions:otherAction arguments:argList];
    va_end(argList);
    return self;
}

- (NSInteger)addAction:(TCAlertAction *)action
{
    if (nil == action) {
        return NSNotFound;
    }
    NSInteger buttonIndex = [self addButtonWithTitle:action.title];
    [[self buttonItems] addObject:action];
    
    if (nil == self.delegate) {
        self.delegate = self;
    }
    
    return buttonIndex;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // If the button index is -1 it means we were dismissed with no selection
    if (buttonIndex >= 0) {
        TCAlertAction *item = [self.buttonItems objectAtIndex:buttonIndex];
        if(item.handler) {
            item.handler(item);
            item.handler = nil;
        }
    }
    
    objc_setAssociatedObject(self, &kRI_BUTTON_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)buttonItems
{
    NSMutableArray *buttonItems = objc_getAssociatedObject(self, &kRI_BUTTON_ASS_KEY);
    if (nil == buttonItems) {
        buttonItems = [NSMutableArray array];
        objc_setAssociatedObject(self, &kRI_BUTTON_ASS_KEY, buttonItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return buttonItems;
}

@end
