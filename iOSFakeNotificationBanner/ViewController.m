//
//  ViewController.m
//  iOSFakeNotificationBanner
//
//  Created by Felix Ln on 2014/9/29.
//  Copyright (c) 2014年 com.lbh.fakenotificationbanner. All rights reserved.
//

#import "ViewController.h"
#import "NotificationCenter.h"
#import "NotificationBannerPresenterIOS7.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize but;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendNotification:(id)sender {
    [self task];
    
}

- (void)task{
    [NotificationCenter sharedCenter].presenter = [NotificationBannerPresenterIOS7 new];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"messager" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    [NotificationCenter
     enqueueNotificationWithTitle:@"Title"
     message:@"message"
     image:image tapHandler:^{
         UIAlertView* alert = [[UIAlertView alloc]
                               initWithTitle:@"Title"
                               message:@"Message"
                               delegate:nil
                               cancelButtonTitle:@"OK"
                               otherButtonTitles:nil];
         [alert show];
     }];

}


@end
