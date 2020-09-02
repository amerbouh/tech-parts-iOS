//
//  AppDelegate.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "AppDelegate.h"
#import "LogController.h"
#import "StartupController.h"
#import "SessionController.h"
#import "NotificationsController.h"
#import "ViewWorkInProgressIntent.h"
#import "RegistrationTokenRepository.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    StartupController const * const startupController = [[StartupController alloc] initWithApp:application];
    
    // Run the startup sequence.
    [startupController runStartupSequence];
    
    return YES;
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"An error occurred while trying the register the user for remote notifications : %@", error);
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler
{
    if ([userActivity.activityType isEqualToString:NSStringFromClass(ViewWorkInProgressIntent.self)]) {
        UITabBarController * rootViewController = (UITabBarController *) self.window.rootViewController;
        
        // Make sure that the application's root view controller instance is not NULL.
        if (rootViewController == NULL) return NO;
        
        // Pass the user activity to the passed in view controllers to route the user to the part of the app used to display
        // assemblies.
        restorationHandler(rootViewController.viewControllers);
        
        return YES;
    }
    
    // Display a message on the console to inform that the user's activity could not be continued.
    NSLog(@"Can't continue unknown NSUserActivity type %@", userActivity.activityType);
    
    return NO;
}

#pragma mark - FIRMessaging delegate

- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken
{
    RegistrationTokenRepository const * const registrationTokenRepository = [RegistrationTokenRepository new];
    NotificationsController const * const remoteNotificationsController = [[NotificationsController alloc] initWithLoggingManager:[LogController sharedInstance] registrationTokenSaver:registrationTokenRepository];
    
    // Obtain the user identifier associated with the current session.
    NSString * const currentUserIdentifier = [[SessionController new] getCurrentUserId];
    
    // Send the registration token to the server if a session is currently active.
    if (currentUserIdentifier != NULL) {
        [remoteNotificationsController sendRegistrationTokenToServer:fcmToken forUserWithIdentifier:currentUserIdentifier];
    }
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options
{
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions
{
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
