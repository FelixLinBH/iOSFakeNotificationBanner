//
//  NotificationBannerPresenterIOS7.m
//  iOSFakeNotificationBanner
//
//  Created by Felix Ln on 2014/9/29.
//  Copyright (c) 2014年 com.lbh.fakenotificationbanner. All rights reserved.
//

#import "NotificationBannerPresenterIOS7.h"
#import "NotificationBannerPresenter_Private.h"

@implementation NotificationBannerPresenterIOS7

- (id) init {
    if (self = [super init]) {
        self.bannerHeight = 60.0;
        self.bannerMaxWidth = [[UIScreen mainScreen] bounds].size.width;
    }
    return self;
}

- (void) presentNotification:(NotificationBanner*)notification
                    inWindow:(NotificationBannerWindow*)window
                    finished:(TapHandlingBlock)finished {
    NotificationBannerView* banner = (NotificationBannerView*)[self newBannerViewForNotification:notification];
    
    UIViewController* bannerViewController = [UIViewController new];
    window.rootViewController = bannerViewController;
    UIView* originalControllerView = bannerViewController.view;
    
    UIView* containerView = [self newContainerViewForNotification:notification];
    [containerView addSubview:banner];
    bannerViewController.view = containerView;
    
    window.bannerView = banner;
    
    containerView.bounds = originalControllerView.bounds;
    containerView.transform = originalControllerView.transform;
    [banner getPresentingState:YES];
    
    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    // Make the banner fill the width of the screen, minus any requested margins,
    // up to self.bannerMaxWidth.
    CGSize bannerSize = CGSizeMake(MIN(self.bannerMaxWidth, originalControllerView.bounds.size.width), self.bannerHeight);
    // Center the banner horizontally.
    CGFloat x = (MAX(statusBarSize.width, statusBarSize.height) / 2) - (bannerSize.width / 2);
    // Position the banner offscreen vertically.
    CGFloat y = -self.bannerHeight;
    
#ifdef __IPHONE_7_0
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    BOOL accountForStatusBarHeight = ([[UIDevice currentDevice].systemVersion intValue] < 7);
#else
    // We're building for a pre-iOS7 base SDK.
    BOOL accountForStatusBarHeight = YES;
#endif
#else
    // We don't even have access to the iOS 7 availability constants.
    BOOL accountForStatusBarHeight = YES;
#endif
    if (accountForStatusBarHeight) {
        y -= (MIN(statusBarSize.width, statusBarSize.height));
    }
    
    banner.frame = CGRectMake(x, y, bannerSize.width, bannerSize.height);
    
    TapHandlingBlock originalTapHandler = banner.notificationBanner.tapHandler;
    TapHandlingBlock wrappingTapHandler = ^{
        if ([banner getPresentingState:NO]) {
            if (originalTapHandler) {
                originalTapHandler();
            }
            
            [banner removeFromSuperview];
            finished();
            // Break the retain cycle
            notification.tapHandler = nil;
        }
    };
    banner.notificationBanner.tapHandler = wrappingTapHandler;
    
    // Slide it down while fading it in.
    banner.alpha = 0.5;
    [UIView animateWithDuration:0.5 delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect newFrame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
                         banner.frame = newFrame;
                         banner.alpha = 0.9;
                     } completion:^(BOOL finished) {
                         // Empty.
                     }];
    
    
    // On timeout, slide it up while fading it out.
    if (notification.timeout > 0.0) {
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, notification.timeout * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
                                 banner.alpha = 0;
                             } completion:^(BOOL didFinish) {
                                 if ([banner getPresentingState:NO]) {
                                     [banner removeFromSuperview];
                                     [containerView removeFromSuperview];
                                     finished();
                                     // Break the retain cycle
                                     notification.tapHandler = nil;
                                 }
                             }];
        });
    }
}

#pragma mark - View

- (NotificationBannerWindow*) newWindow {
    NotificationBannerWindow* window = [super newWindow];
    window.windowLevel = UIWindowLevelStatusBar;
    return window;
}

- (UIView*) newContainerViewForNotification:(NotificationBanner*)notification {
    UIView* view = [super newContainerViewForNotification:notification];
    view.autoresizesSubviews = YES;
    return view;
}

- (NotificationBannerView*) newBannerViewForNotification:(NotificationBanner*)notification {
    NotificationBannerView* view = [[NotificationBannerView alloc]
                                               initWithNotification:notification];
    view.userInteractionEnabled = YES;
    view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleLeftMargin
    | UIViewAutoresizingFlexibleRightMargin;
    return view;
}

@end
