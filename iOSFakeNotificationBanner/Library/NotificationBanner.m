//
//  NotificationBanner.m
//  iOSFakeNotificationBanner
//
//  Created by Felix Ln on 2014/9/29.
//  Copyright (c) 2014年 com.lbh.fakenotificationbanner. All rights reserved.
//

#import "NotificationBanner.h"

@implementation NotificationBanner

@synthesize title;
@synthesize image;
@synthesize message;
@synthesize timeout;
@synthesize tapHandler;

- (NotificationBanner*) initWithTitle:(NSString*)_title
                                message:(NSString*)_message
                                  image:(UIImage*)_image
                             tapHandler:(TapHandlingBlock)_tapHandler {
    
    return [self initWithTitle:_title message:_message image:_image timeout:3.0 tapHandler:_tapHandler];
}

- (NotificationBanner*) initWithTitle:(NSString*)_title
                                message:(NSString*)_message
                                  image:(UIImage*)_image
                                timeout:(NSTimeInterval)_timeout
                             tapHandler:(TapHandlingBlock)_tapHandler {
    
    self = [super init];
    if (self) {
        self.title = _title;
        self.message = _message;
        self.image = _image;
        self.timeout = _timeout;
        self.tapHandler = _tapHandler;
    }
    return self;
}

@end
