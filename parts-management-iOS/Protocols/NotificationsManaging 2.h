//
//  NotificationsManaging.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-05-23.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NotificationsManaging <NSObject>

/**
 @brief Saves the given registration token on the Realtime Database and associates it with the given user identifier.
 
 @param registrationToken A string representing the registration token to save.
 @param userIdentifier        A string representing the unique identifier of the user the registration token belongs to.
 */
- (void)sendRegistrationTokenToServer:(NSString * _Nonnull)registrationToken forUserWithIdentifier:(NSString * _Nonnull)userIdentifier;

@end

NS_ASSUME_NONNULL_END
