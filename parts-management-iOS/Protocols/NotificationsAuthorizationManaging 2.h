//
//  NotificationsAuthorizationManaging.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-05-23.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NotificationsAuthorizationManaging <NSObject>

/** @brief Prompts the user to authorize notification's alerts and sounds. */
- (void)requestNotificationsAuthorization:(void (^_Nullable)(void))completionHandler;

@end

NS_ASSUME_NONNULL_END
