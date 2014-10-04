//
//  ViewController.h
//  iOSFakeNotificationBanner
//
//  Created by Felix Ln on 2014/9/29.
//  Copyright (c) 2014年 com.lbh.fakenotificationbanner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationBannerPresenter.h"
@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *but;
- (IBAction)sendNotification:(id)sender;



@end

