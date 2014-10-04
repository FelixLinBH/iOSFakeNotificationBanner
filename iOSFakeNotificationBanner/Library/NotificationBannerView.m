//
//  NotificationBannerView.m
//  iOSFakeNotificationBanner
//
//  Created by Felix Ln on 2014/9/29.
//  Copyright (c) 2014年 com.lbh.fakenotificationbanner. All rights reserved.
//

#import "NotificationBannerView.h"

const CGFloat NotificationBannerViewOutlineWidth = 2.0;
const CGFloat NotificationBannerViewMarginX = 15.0;
const CGFloat NotificationBannerViewMarginY = 5.0;

@interface NotificationBannerView (){
    BOOL isPresented;
    NSObject* isPresentedMutex;
}

- (void) handleSingleTap:(UIGestureRecognizer*)gestureRecognizer;

@end

@implementation NotificationBannerView

@synthesize notificationBanner;
@synthesize imageView;
@synthesize titleLabel;
@synthesize messageLabel;

- (id) initWithNotification:(NotificationBanner *)notification{
    self = [super init];
    if (self) {
        isPresentedMutex = [NSObject new];
        self.backgroundColor = [UIColor clearColor];
        self.imageView = [UIImageView new];
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.messageLabel = [UILabel new];
        self.messageLabel.font = [UIFont systemFontOfSize:14];
        self.messageLabel.backgroundColor = [UIColor clearColor];
        self.messageLabel.numberOfLines = 0;
        self.notificationBanner = notification;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.messageLabel.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.9];
        UITapGestureRecognizer* tapRecognizer;
        tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
        
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.messageLabel];
        [self addGestureRecognizer:tapRecognizer];
        
        
    }
    return self;
}

- (void) setNotificationBanner:(NotificationBanner*)notification {
    notificationBanner = notification;
    
    self.titleLabel.text = notification.title;
    self.messageLabel.text = notification.message;
    self.imageView.image = notification.image;
}

- (void) handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    if (notificationBanner && notificationBanner.tapHandler) {
        notificationBanner.tapHandler();
    }
}

-(BOOL) getPresentingState:(BOOL)state {
    @synchronized(isPresentedMutex) {
        BOOL originalState = isPresented;
        isPresented = state;
        return originalState;
    }
}

- (void) layoutSubviews{
    if (!(self.frame.size.width > 0)) {
        return;
    }
    
    CGFloat borderY = NotificationBannerViewOutlineWidth + NotificationBannerViewMarginY;
    CGFloat borderX = NotificationBannerViewOutlineWidth + NotificationBannerViewMarginX;
    CGFloat currentX = borderX;
    CGFloat currentY = borderY;
    CGFloat contentWidth = self.frame.size.width - (borderX * 2.0);
    
    self.imageView.frame = CGRectMake(currentX, currentY,20.0, 20.0);
    self.titleLabel.frame = CGRectMake(currentX + self.imageView.frame.size.width + 12.0, currentY, contentWidth - self.imageView.frame.size.width -12 , 14.0);
    
    
    self.messageLabel.frame = CGRectMake(currentX + self.imageView.frame.size.width + 12.0, currentY + self.titleLabel.frame.size.height , contentWidth - self.imageView.frame.size.width - 12, (self.frame.size.height - borderY) - currentY - self.titleLabel.frame.size.height);
    [self.messageLabel sizeToFit];
    CGRect messageFrame = self.messageLabel.frame;
    CGFloat spillY = (currentY + messageFrame.size.height + NotificationBannerViewMarginY + self.titleLabel.frame.size.height) - self.frame.size.height;
    if (spillY > 0.0) {
        messageFrame.size.height -= spillY;
        self.messageLabel.frame = messageFrame;
    }

}



@end
