//
//  TCAlertController.m
//  TCKit
//
//  Created by dake on 15/3/12.
//  Copyright (c) 2015年 Dake. All rights reserved.
//

#import "TCAlertController.h"

#import "UIAlertView+Blocks.h"
#import "UIActionSheet+Blocks.h"


typedef NS_ENUM(NSInteger, TCAlertControllerStyle) {
#ifdef __IPHONE_8_0
    kTCAlertControllerStyleActionSheet = UIAlertControllerStyleActionSheet,
    kTCAlertControllerStyleAlert = UIAlertControllerStyleAlert,
#else
    kTCAlertControllerStyleActionSheet = 0,
    kTCAlertControllerStyleAlert,
#endif
};


#ifdef __IPHONE_8_0
@interface TCAlertAction (UIKitHelper)

- (UIAlertAction *)toUIAlertAction;

@end

@implementation TCAlertAction (UIKitHelper)

- (UIAlertAction *)toUIAlertAction
{
    void (^handler)(UIAlertAction *action) = nil;
    if (nil != self.handler) {
        handler = ^(UIAlertAction *action) {
            self.handler(self);
            self.handler = nil;
        };
    }
    UIAlertAction *action = [UIAlertAction actionWithTitle:self.title style:(UIAlertActionStyle)self.style handler:handler];
    return action;
}

@end

#endif


@implementation TCAlertController
{
    @private
    id _alertView;
    __weak UIViewController *_parentCtrler;
    TCAlertControllerStyle _preferredStyle;
}



- (instancetype)initAlertViewWithTitle:(NSString *)title
                               message:(NSString *)message
                         presentCtrler:(UIViewController *)viewCtrler
                          cancelAction:(TCAlertAction *)cancelAction
                          otherActions:(NSArray *)otherActions
{
    self = [super init];
    if (self) {
        _preferredStyle = kTCAlertControllerStyleAlert;
        
#ifndef __IPHONE_8_0
            _alertView = [[UIAlertView alloc] initWithTitle:title message:message cancelAction:cancelAction otherActions:otherActions];
#else
        if (Nil == [UIAlertController class]) {
            _alertView = [[UIAlertView alloc] initWithTitle:title message:message cancelAction:cancelAction otherActions:otherActions];
        }
        else {
            
            UIAlertController *alertCtrler = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            
            if (nil != cancelAction) {
                [alertCtrler addAction:cancelAction.toUIAlertAction];
            }
            
            for (TCAlertAction *eachItem in otherActions) {
                [alertCtrler addAction:eachItem.toUIAlertAction];
            }

            _alertView = alertCtrler;
            _parentCtrler = viewCtrler ?: [UIApplication sharedApplication].keyWindow.rootViewController;
        }
#endif
    }
    
    return self;
}

- (instancetype)initAlertViewWithTitle:(NSString *)title
                               message:(NSString *)message
                         presentCtrler:(UIViewController *)viewCtrler
                          cancelAction:(TCAlertAction *)cancelAction
                           otherAction:(TCAlertAction *)otherAction, ...
{
    NSMutableArray *arry = nil;
    if (nil != otherAction) {
        arry = [NSMutableArray array];
        TCAlertAction *eachItem = otherAction;
        va_list argumentList;
        va_start(argumentList, otherAction);
        do {
            [arry addObject:eachItem];
            eachItem = va_arg(argumentList, TCAlertAction *);
        } while (nil != eachItem);
        va_end(argumentList);
    }
    
    return [self initAlertViewWithTitle:title message:message presentCtrler:viewCtrler cancelAction:cancelAction otherActions:arry];
}


- (instancetype)initActionSheetWithTitle:(NSString *)title
                           presentCtrler:(UIViewController *)viewCtrler
                            cancelAction:(TCAlertAction *)cancelAction
                       destructiveAction:(TCAlertAction *)destructiveAction
                            otherActions:(NSArray *)otherActions
{
    self = [super init];
    if (self) {
        
        _preferredStyle = kTCAlertControllerStyleActionSheet;
        _parentCtrler = viewCtrler ?: [UIApplication sharedApplication].keyWindow.rootViewController;
        
#ifndef __IPHONE_8_0
            _alertView = [[UIActionSheet alloc] initWithTitle:title cancelAction:cancelAction destructiveAction:destructiveAction otherActions:otherActions];
#else
        if (Nil == [UIAlertController class]) {
            _alertView = [[UIActionSheet alloc] initWithTitle:title cancelAction:cancelAction destructiveAction:destructiveAction otherActions:otherActions];
        }
        else {
            
            UIAlertController *alertCtrler = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            if (nil != cancelAction) {
                [alertCtrler addAction:cancelAction.toUIAlertAction];
            }
            
            if (nil != destructiveAction) {
                [alertCtrler addAction:destructiveAction.toUIAlertAction];
            }
            
            for (TCAlertAction *eachItem in otherActions) {
                [alertCtrler addAction:eachItem.toUIAlertAction];
            }
            
            _alertView = alertCtrler;
        }
#endif
    }
    
    return self;
}


- (instancetype)initActionSheetWithTitle:(NSString *)title
                           presentCtrler:(UIViewController *)viewCtrler
                            cancelAction:(TCAlertAction *)cancelAction
                       destructiveAction:(TCAlertAction *)destructiveAction
                             otherAction:(TCAlertAction *)otherAction, ...
{
    NSMutableArray *arry = nil;
    if (nil != otherAction) {
        arry = [NSMutableArray array];
        TCAlertAction *eachItem = otherAction;
        va_list argumentList;
        va_start(argumentList, otherAction);
        do {
            [arry addObject:eachItem];
            eachItem = va_arg(argumentList, TCAlertAction *);
        } while (nil != eachItem);
        va_end(argumentList);
    }
    return [self initActionSheetWithTitle:title presentCtrler:viewCtrler cancelAction:cancelAction destructiveAction:destructiveAction otherActions:arry];
}


- (void)addAction:(TCAlertAction *)action
{
    if (_preferredStyle == kTCAlertControllerStyleAlert || _preferredStyle == kTCAlertControllerStyleActionSheet) {
        
        if ([_alertView isKindOfClass:[UIAlertView class]]) {
            [((UIAlertView *)_alertView) addAction:action];
        }
        else if ([_alertView isKindOfClass:[UIActionSheet class]]) {
            [((UIActionSheet *)_alertView) addAction:action];
        }
        else {
#ifdef __IPHONE_8_0
            [((UIAlertController *)_alertView) addAction:action.toUIAlertAction];
#endif
        }
    }
    else {
        @throw [NSException exceptionWithName:NSStringFromClass(self.class) reason:@"unknown present style" userInfo:nil];
    }
}

- (void)show
{
    if (_preferredStyle == kTCAlertControllerStyleAlert) {
        if ([_alertView isKindOfClass:[UIAlertView class]]) {
            [((UIAlertView *)_alertView) show];
        }
        else {
           [_parentCtrler presentViewController:_alertView animated:YES completion:nil];
        }
    }
    else if (_preferredStyle == kTCAlertControllerStyleActionSheet) {
        if ([_alertView isKindOfClass:[UIActionSheet class]]) {
            [((UIActionSheet *)_alertView) showInView:_parentCtrler.view];
        }
        else {
            [_parentCtrler presentViewController:_alertView animated:YES completion:nil];
        }
    }
    else {
        @throw [NSException exceptionWithName:NSStringFromClass(self.class) reason:@"unknown present style" userInfo:nil];
    }
    
    _alertView = nil;
}

@end
