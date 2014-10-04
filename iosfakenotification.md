# iOSFakeNotification

## Preview

![preview](https://github.com/humdrum81211/iOSFakeNotificationBanner/blob/master/resource/ios.gif)

### Getting Started
#### Import
	#import "NotificationCenter.h"
	#import "NotificationBannerPresenterIOS7.h"
	
#### Creat instance
	[NotificationCenter sharedCenter].presenter = [NotificationBannerPresenterIOS7 new];

##### Do Notification

	+ (void) enqueueNotificationWithTitle:(NSString*)title
                              message:(NSString*)message
                                image:(UIImage*)image
                  tapHandler:(TapHandlingBlock)tapHandler ;

