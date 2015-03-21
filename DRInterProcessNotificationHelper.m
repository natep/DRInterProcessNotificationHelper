//
//  DRInterProcessNotificationHelper.m
//
//  Created by Nate Petersen on 12/7/14.
//  Copyright (c) 2014 Digital Rickshaw. All rights reserved.
//

#import "DRInterProcessNotificationHelper.h"

@implementation DRInterProcessNotificationHelper

+ (void)startMonitoringNotificationsWithName:(NSString*)name
{
	CFNotificationCenterRef const center = CFNotificationCenterGetDarwinNotifyCenter();
	
	// per the docs, all params that are ignored by Darwin notifications should be NULL or 0
	CFNotificationCenterAddObserver(center, NULL, interProcessNotificationCallback, (CFStringRef)name, NULL, 0);
}

+ (void)stopMonitoringNotificationsWithName:(NSString*)name
{
	CFNotificationCenterRef const center = CFNotificationCenterGetDarwinNotifyCenter();
	
	// per the docs, all params that are ignored by Darwin notifications should be NULL or 0
	CFNotificationCenterRemoveObserver(center, NULL, (CFStringRef)name, NULL);
}

void interProcessNotificationCallback(CFNotificationCenterRef center,
									  void * observer,
									  CFStringRef name,
									  void const * object,
									  CFDictionaryRef userInfo)
{
	// re-broadcast the notification through the standard NSNotificationCenter
	[[NSNotificationCenter defaultCenter] postNotificationName:(__bridge NSString*)name object:nil];
}

+ (void)postNotificationWithName:(NSString*)name
{
	CFNotificationCenterRef const center = CFNotificationCenterGetDarwinNotifyCenter();

	// per the docs, all params that are ignored by Darwin notifications should be NULL or 0
	CFNotificationCenterPostNotification(center, (CFStringRef)name, NULL, NULL, 0);
}

@end
