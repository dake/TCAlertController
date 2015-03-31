//
//  TCAlertAction.h
//  TCKit
//
//  Created by dake on 15/3/12.
//  Copyright (c) 2015年 Dake. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, TCAlertActionStyle) {
#ifdef __IPHONE_8_0
    kTCAlertActionStyleDefault = UIAlertActionStyleDefault,
    kTCAlertActionStyleCancel = UIAlertActionStyleCancel,
    kTCAlertActionStyleDestructive = UIAlertActionStyleDestructive,
#else
    kTCAlertActionStyleDefault = 0,
    kTCAlertActionStyleCancel,
    kTCAlertActionStyleDestructive,
#endif
};


@interface TCAlertAction : NSObject //<NSCopying>

+ (instancetype)actionWithTitle:(NSString *)title style:(TCAlertActionStyle)style handler:(void (^)(TCAlertAction *action))handler;

+ (instancetype)defaultActionWithTitle:(NSString *)title handler:(void (^)(TCAlertAction *action))handler;
+ (instancetype)cancelActionWithTitle:(NSString *)title handler:(void (^)(TCAlertAction *action))handler;
+ (instancetype)destructiveActionWithTitle:(NSString *)title handler:(void (^)(TCAlertAction *action))handler;

@property (nonatomic, assign, readonly) NSString *title;
@property (nonatomic, assign, readonly) TCAlertActionStyle style;
@property (nonatomic, copy) void (^handler)(TCAlertAction *action);

@end
