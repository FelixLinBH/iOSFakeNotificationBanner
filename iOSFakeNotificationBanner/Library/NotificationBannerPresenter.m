//
//  NotificationBannerPresenter.m
//  iOSFakeNotificationBanner
//
//  Created by Felix Ln on 2014/9/29.
//  Copyright (c) 2014年 com.lbh.fakenotificationbanner. All rights reserved.
//

#import "NotificationBannerPresenter.h"
#import "NotificationBannerPresenter_Private.h"

@implementation NotificationBannerPresenter

- (void) willBeginPresentingNotifications {
    bannerWindow = [self newWindow];
}

- (void) didFinishPresentingNotifications{
    bannerWindow.hidden = YES;
    [bannerWindow removeFromSuperview];
    bannerWindow.rootViewController = nil;
    bannerWindow = nil;
}

//override
- (void) presentNotification:(NotificationBanner*)notification
                    inWindow:(NotificationBannerWindow*)window
                    finished:(TapHandlingBlock)finished {
}
- (void) presentNotification:(NotificationBanner*)notification
                    finished:(TapHandlingBlock)finished {
    [self presentNotification:notification
                     inWindow:bannerWindow
                     finished:finished];
    
}


#pragma mark - View

- (NotificationBannerWindow*) newWindow {
    NotificationBannerWindow* window = [[NotificationBannerWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    window.userInteractionEnabled = YES;
    window.autoresizesSubviews = YES;
    window.opaque = NO;
    window.hidden = NO;
    return window;
}

- (UIView*) newContainerViewForNotification:(NotificationBanner*)notification{
    UIView* container = [UIView new];
    container.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    container.userInteractionEnabled = YES;
    container.opaque = NO;
    return container;
}

- (NotificationBannerView*) newBannerViewForNotification:(NotificationBanner*)notification {
    NotificationBannerView* view = [[NotificationBannerView alloc]initWithNotification:notification];
    view.userInteractionEnabled = YES;
    view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleLeftMargin
    | UIViewAutoresizingFlexibleRightMargin;
    return view;
}
@end
