//
//  TCAlertAction.m
//  TCKit
//
//  Created by dake on 15/3/12.
//  Copyright (c) 2015年 Dake. All rights reserved.
//

#import "TCAlertAction.h"


@interface TCAlertAction ()

@property (nonatomic, assign, readwrite) NSString *title;
@property (nonatomic, assign, readwrite) TCAlertActionStyle style;

@end

@implementation TCAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(TCAlertActionStyle)style handler:(void (^)(TCAlertAction *action))handler
{
    TCAlertAction *action = [[self alloc] init];
    action.title = title;
    action.style = style;
    action.handler = handler;
    
    return action;
}

+ (instancetype)defaultActionWithTitle:(NSString *)title handler:(void (^)(TCAlertAction *action))handler
{
    return [self actionWithTitle:title style:kTCAlertActionStyleDefault handler:handler];
}

+ (instancetype)cancelActionWithTitle:(NSString *)title handler:(void (^)(TCAlertAction *action))handler
{
    return [self actionWithTitle:title style:kTCAlertActionStyleCancel handler:handler];
}

+ (instancetype)destructiveActionWithTitle:(NSString *)title handler:(void (^)(TCAlertAction *action))handler
{
    return [self actionWithTitle:title style:kTCAlertActionStyleDestructive handler:handler];
}

@end