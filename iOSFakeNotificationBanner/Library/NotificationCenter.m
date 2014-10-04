//
//  NotificationCenter.m
//  iOSFakeNotificationBanner
//
//  Created by Felix Ln on 2014/9/30.
//  Copyright (c) 2014年 com.lbh.fakenotificationbanner. All rights reserved.
//

#import "NotificationCenter.h"

@interface NotificationCenter (){
    @private
    NSMutableArray* enqueuedNotifications;
    NSLock* isPresentingMutex;
    NSObject* notificationQueueMutex;
    NotificationBannerPresenter* _currentPresenter;
    NotificationBannerPresenter* _nextPresenter;
}
@end

@implementation NotificationCenter

- (NotificationCenter*) init {
    self = [super init];
    if (self) {
        enqueuedNotifications = [NSMutableArray new];
        isPresentingMutex = [NSLock new];
        notificationQueueMutex = [NSObject new];
        self.presenter = [[[self class] presenterClass] new];
    }
    return self;
}

+ (NotificationCenter*) sharedCenter {
    static NotificationCenter* sharedCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCenter = [[self class] new];
    });
    return sharedCenter;
}

+ (Class) presenterClass {
    return [NotificationBannerPresenter class];
}

+ (void) enqueueNotificationWithTitle:(NSString*)title
                              message:(NSString*)message
                                image:(UIImage*)image
                           tapHandler:(TapHandlingBlock)tapHandler {
    NotificationBanner* notification = [[NotificationBanner alloc] initWithTitle:title
                                                                             message:message
                                                                               image:image              tapHandler:tapHandler];
    [[self sharedCenter] enqueueNotification:notification];
}


- (NotificationBanner*) dequeueNotification {
    NotificationBanner* notification;
    @synchronized(notificationQueueMutex) {
        if ([enqueuedNotifications count] > 0) {
            notification = [enqueuedNotifications objectAtIndex:0];
            [enqueuedNotifications removeObjectAtIndex:0];
        }
    }
    return notification;
}

- (void) donePresentingNotification:(NotificationBanner*)notification {

    [isPresentingMutex unlock];
    [self beginPresentingNotifications];
}

- (void) setPresenter:(NotificationBannerPresenter*)presenter {
    _nextPresenter = presenter;
}

- (NotificationBannerPresenter*) presenter {
    return _nextPresenter;
}

- (void) beginPresentingNotifications {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([isPresentingMutex tryLock]) {
            // Check to see if the nextPresenter has changed *during* a group
            // of notifications.
            if (_currentPresenter != _nextPresenter) {
                // Finish up with the original one.
                [_currentPresenter didFinishPresentingNotifications];
                _currentPresenter = nil;
            }
            
            if (!_currentPresenter) {
                _currentPresenter = _nextPresenter;
                [_currentPresenter willBeginPresentingNotifications];
            }
            NotificationBanner* nextNotification = [self dequeueNotification];
            if (nextNotification) {
                [_currentPresenter presentNotification:nextNotification
                                              finished:^{
                                                  [self donePresentingNotification:nextNotification];
                                              }];
            } else {
                [_currentPresenter didFinishPresentingNotifications];
                _currentPresenter = nil;
                [isPresentingMutex unlock];
            }
        } else {
        
        }
    });
}


- (void) enqueueNotification:(NotificationBanner*)notification {
    @synchronized(notificationQueueMutex) {
        [enqueuedNotifications addObject:notification];
    }
    [self beginPresentingNotifications];
}



@end
