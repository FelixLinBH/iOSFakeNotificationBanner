//
//  NotificationCenter.h
//  iOSFakeNotificationBanner
//
//  Created by Felix Ln on 2014/9/30.
//  Copyright (c) 2014年 com.lbh.fakenotificationbanner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotificationBanner.h"
#import "NotificationBannerPresenter.h"
@class NotificationBannerPresenter;

@interface NotificationCenter : NSObject

@property (nonatomic) NotificationBannerPresenter* presenter;

+ (NotificationCenter*) sharedCenter;

+ (void) enqueueNotificationWithTitle:(NSString*)title
                              message:(NSString*)message
                                image:(UIImage*)image
                           tapHandler:(TapHandlingBlock)tapHandler;

- (void) enqueueNotification:(NotificationBanner*)notification;

@end
