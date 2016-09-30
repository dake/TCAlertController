//
//  TCAlertViewDelegate.h
//  TCKit
//
//  Created by dake on 16/2/1.
//  Copyright © 2016年 dake. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0

@interface TCAlertViewDelegate : NSObject <UIAlertViewDelegate, UIActionSheetDelegate>

@end

#endif
