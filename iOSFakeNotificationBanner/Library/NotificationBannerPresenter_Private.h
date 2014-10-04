//
//  NotificationBannerPresenter_Private.h
//  iOSFakeNotificationBanner
//
//  Created by Felix Ln on 2014/9/30.
//  Copyright (c) 2014年 com.lbh.fakenotificationbanner. All rights reserved.
//


#ifndef iOSFakeNotificationBanner_NotificationBannerPresenter_Private_h
#define iOSFakeNotificationBanner_NotificationBannerPresenter_Private_h
#import <Foundation/Foundation.h>
#import "NotificationBannerView.h"
#import "NotificationBannerWindow.h"
@interface NotificationBannerPresenter () {
    @private
    NotificationBannerWindow* bannerWindow;
    
}

- (void) presentNotification:(NotificationBanner*)notification
                    inWindow:(NotificationBannerWindow*)window
                    finished:(TapHandlingBlock)finished;

#pragma mark - View helpers
- (UIView*) newContainerViewForNotification:(NotificationBanner*)notification;
- (NotificationBannerWindow*) newWindow;
- (NotificationBannerView*) newBannerViewForNotification:(NotificationBanner*)notification;

@end

#endif
