//
//  RemoteNotificationsController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-05-23.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "NotificationsController.h"
#import <UserNotifications/UNUserNotificationCenter.h>

@implementation NotificationsController {
    id <FIRRegistrationTokenSaving> _registrationTokenSaver;
    UNUserNotificationCenter const * _userNotificationCenter;
}

#pragma mark - Initialization

- (instancetype)init:(id <FIRRegistrationTokenSaving>)registrationTokenSaver
{
    self = [super init];
    if (self) {
        _registrationTokenSaver = registrationTokenSaver;
        _userNotificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    }
    return self;
}

#pragma mark - Methods

- (void)requestNotificationsAuthorization:(void (^)(void))completionHandler
{
    UNAuthorizationOptions const authorizationOptions = UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge;
    
    // Request the user's authorization to receive notifications.
    [_userNotificationCenter requestAuthorizationWithOptions:authorizationOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted == NO) NSLog(@"L'utilisateur n'a pas autorisé la réception de notifications.");
        
        // Call the completion handler.
        completionHandler();
    }];
}

- (void)sendRegistrationTokenToServer:(NSString *)registrationToken forUserWithIdentifier:(NSString *)userIdentifier
{
    [_registrationTokenSaver saveRegistrationToken:registrationToken forUserWithIdentifier:userIdentifier];
}

@end
