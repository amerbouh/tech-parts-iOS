//
//  AppDelegate.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "AppDelegate.h"
#import <Realm/Realm.h>
#import <Firebase/Firebase.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import <FirebaseMessaging/FirebaseMessaging.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()

- (void)requestNotificationsAuthorization;
- (void)attemptRemoteNotificationsRegistration;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions
{
    [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [FIRApp configure];
    
    // Assign the FIRMessaging's delegate.
    [FIRMessaging.messaging setDelegate:self];
    
    // Request the user's authorization to receive notifications.
    [self requestNotificationsAuthorization];
    
    // Attempt to register for remote notifications.
    [self attemptRemoteNotificationsRegistration];

    return YES;
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"An error occurred while trying the register the user for remote notifications : %@", error);
}

#pragma mark - Methods

- (void)requestNotificationsAuthorization
{
    UNAuthorizationOptions const authorizationOptions = UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge;
    
    // Request the user's authorization to receive notifications.
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authorizationOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted == NO) NSLog(@"L'utilisateur n'a pas autorisé la réception de notifications.");
    }];
}

- (void)attemptRemoteNotificationsRegistration
{
    UNUserNotificationCenter * const userNotificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    
    // Get the current notification settings.
    [userNotificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus != UNAuthorizationStatusAuthorized) return;
        
        // Dispatch the remote notifications registration block to the main thread.
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        });
    }];
}

#pragma mark - FIRMessaging delegate

- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken
{
    NSLog(@"L'appareil de l'utilisateur a été enregistré avec FCM avec succèes ! Son device token est: %@", fcmToken);
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
