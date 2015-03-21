//
//  DRInterProcessNotificationHelper.h
//
//  Created by Nate Petersen on 12/7/14.
//  Copyright (c) 2014 Digital Rickshaw. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Facilitates the posting of notifications between different processes.
 * For instance, between a container app and an extension.
 *
 * This is a thin wrapper around Core Foundation's Darwin notification center.
 * Which is itself a wrapper around <notify.h>.
 */
@interface DRInterProcessNotificationHelper : NSObject

/**
 * Requests that the helper start listening for inter-process notifications
 * with the given name. If one is received, it is re-broadcast within the app
 * using the default NSNotificationCenter.
 */
+ (void)startMonitoringNotificationsWithName:(NSString*)name;

/**
 * Requests that the helper stop listening for inter-process notifications
 * with the given name.
 */
+ (void)stopMonitoringNotificationsWithName:(NSString*)name;

/**
 * Requests that the helper post an inter-process notification with the given
 * name. NOTE: Any listening process may receive this notification, even the
 * process that sent it.
 */
+ (void)postNotificationWithName:(NSString*)name;

@end
