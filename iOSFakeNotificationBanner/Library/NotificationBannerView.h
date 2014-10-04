//
//  NotificationBannerView.h
//  iOSFakeNotificationBanner
//
//  Created by Felix Ln on 2014/9/29.
//  Copyright (c) 2014年 com.lbh.fakenotificationbanner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NotificationBanner.h"
@interface NotificationBannerView : UIView

@property (nonatomic) NotificationBanner* notificationBanner;
@property (nonatomic) UIImageView* imageView;
@property (nonatomic) UILabel* titleLabel;
@property (nonatomic) UILabel* messageLabel;
-(id) initWithNotification:(NotificationBanner *)notification;
-(BOOL) getPresentingState:(BOOL)state;

@end
