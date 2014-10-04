//
//  NotificationBanner.h
//  iOSFakeNotificationBanner
//
//  Created by Felix Ln on 2014/9/29.
//  Copyright (c) 2014年 com.lbh.fakenotificationbanner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^TapHandlingBlock)();
@interface NotificationBanner : NSObject

@property (nonatomic) NSString* title;
@property (nonatomic) UIImage* image;
@property (nonatomic) NSString* message;
@property (nonatomic, assign) NSTimeInterval timeout;
@property (nonatomic, copy) TapHandlingBlock tapHandler;

- (NotificationBanner*) initWithTitle:(NSString*)_title
                                message:(NSString*)_message
                                  image:(UIImage*)_image
                             tapHandler:(TapHandlingBlock)_tapHandler;


@end
