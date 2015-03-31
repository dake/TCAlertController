//  UIActionSheet+Blocks.m
//  TCKit
//
//  Created by dake on 15/3/12.
//  Copyright (c) 2015年 Dake. All rights reserved.
//

#import "UIActionSheet+Blocks.h"
#import <objc/runtime.h>
#import "TCAlertAction.h"

static char const kRI_BUTTON_ASS_KEY;
static char const kRI_DISMISSAL_ACTION_KEY;

@implementation UIActionSheet (Blocks)

- (void(^)())dismissalAction
{
    return objc_getAssociatedObject(self, &kRI_DISMISSAL_ACTION_KEY);
}

- (void)setDismissalAction:(void(^)())dismissalAction
{
    objc_setAssociatedObject(self, &kRI_DISMISSAL_ACTION_KEY, nil, OBJC_ASSOCIATION_COPY);
    if (nil != dismissalAction) {
        objc_setAssociatedObject(self, &kRI_DISMISSAL_ACTION_KEY, dismissalAction, OBJC_ASSOCIATION_COPY);
    }
}


- (instancetype)initWithTitle:(NSString *)title cancelAction:(TCAlertAction *)cancelAction destructiveAction:(TCAlertAction *)destructiveAction otherActions:(TCAlertAction *)otherAction arguments:(va_list)argList
{
    if ((self = [self initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:destructiveAction.title otherButtonTitles:nil])){
        NSMutableArray *buttonsArray = [NSMutableArray array];
        if (nil != destructiveAction) {
            [buttonsArray addObject:destructiveAction];
        }
        
        if (nil != otherAction) {
            TCAlertAction *eachItem = otherAction;
            do {
                [buttonsArray addObject:eachItem];
                [self addButtonWithTitle:eachItem.title];
                eachItem = va_arg(argList, TCAlertAction *);
            } while (nil != eachItem);
        }
        
        if (nil != cancelAction) {
            [buttonsArray addObject:cancelAction];
            [self addButtonWithTitle:cancelAction.title];
            self.cancelButtonIndex = [buttonsArray indexOfObject:cancelAction];
        }
        
        objc_setAssociatedObject(self, &kRI_BUTTON_ASS_KEY, buttonsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title cancelAction:(TCAlertAction *)cancelAction destructiveAction:(TCAlertAction *)destructiveAction otherActions:(TCAlertAction *)otherAction, ...
{
    va_list argList;
    va_start(argList, otherAction);
    self = [self initWithTitle:title cancelAction:cancelAction destructiveAction:destructiveAction otherActions:otherAction arguments:argList];
    va_end(argList);
    return self;
}


- (NSInteger)addAction:(TCAlertAction *)action
{
    if (nil == action) {
        return NSNotFound;
    }
    NSMutableArray *buttonsArray = objc_getAssociatedObject(self, &kRI_BUTTON_ASS_KEY);
	NSInteger buttonIndex = [self addButtonWithTitle:action.title];
	[buttonsArray addObject:action];
	
	return buttonIndex;
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // Action sheets pass back -1 when they're cleared for some reason other than a button being 
    // pressed.
    if (buttonIndex >= 0) {
        NSArray *buttonsArray = objc_getAssociatedObject(self, &kRI_BUTTON_ASS_KEY);
        TCAlertAction *item = [buttonsArray objectAtIndex:buttonIndex];
        if (item.handler) {
            item.handler(item);
            item.handler = nil;
        }
    }
    
    if (self.dismissalAction) {
        self.dismissalAction();
        self.dismissalAction = nil;
    }
    
    objc_setAssociatedObject(self, &kRI_BUTTON_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

