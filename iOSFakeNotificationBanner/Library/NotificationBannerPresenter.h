//
//  NotificationBannerPresenter.h
//  iOSFakeNotificationBanner
//
//  Created by Felix Ln on 2014/9/29.
//  Copyright (c) 2014年 com.lbh.fakenotificationbanner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotificationBanner.h"

typedef void (^TapHandlingBlock)();

@interface NotificationBannerPresenter : NSObject

- (void) willBeginPresentingNotifications;
- (void) didFinishPresentingNotifications;
- (void) presentNotification:(NotificationBanner*)notification
                    finished:(TapHandlingBlock)finished;
@end