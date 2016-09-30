//
//  TCAlertViewDelegate.m
//  TCKit
//
//  Created by dake on 16/2/1.
//  Copyright © 2016年 dake. All rights reserved.
//

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0

#import "TCAlertViewDelegate.h"
#import "TCAlertAction.h"

@interface UIAlertView (TCBlocks)

@property (nonatomic, strong) NSMutableArray<TCAlertAction *> *buttonItems;

@end

@interface UIActionSheet (TCBlocks)

@property (nonatomic, strong) NSMutableArray<TCAlertAction *> *buttonItems;
@property (nonatomic, copy) dispatch_block_t dismissalAction;

@end


@implementation TCAlertViewDelegate


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSArray<TCAlertAction *> *buttonItems = alertView.buttonItems;
    // If the button index is -1 it means we were dismissed with no selection
    if (buttonIndex >= 0 && buttonIndex < buttonItems.count) {
        TCAlertAction *item = buttonItems[buttonIndex];
        if (nil != item.handler) {
            item.handler(item);
            item.handler = nil;
        }
    }
    
    alertView.buttonItems = nil;
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // Action sheets pass back -1 when they're cleared for some reason other than a button being
    // pressed.
    
    NSArray<TCAlertAction *> *buttonItems = actionSheet.buttonItems;
    if (buttonIndex >= 0 && buttonIndex < buttonItems.count) {
        
        TCAlertAction *item = buttonItems[buttonIndex];
        if (nil != item.handler) {
            item.handler(item);
            item.handler = nil;
        }
    }
    
    if (nil != actionSheet.dismissalAction) {
        actionSheet.dismissalAction();
        actionSheet.dismissalAction = nil;
    }
    
    actionSheet.buttonItems = nil;
}


@end

#endif
