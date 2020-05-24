//
//  NotificationsController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-05-23.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FIRRegistrationTokenSaving.h"
#import "NotificationsManaging.h"
#import "NotificationsAuthorizationManaging.h"

NS_ASSUME_NONNULL_BEGIN

@interface NotificationsController : NSObject <NotificationsManaging, NotificationsAuthorizationManaging>

/**
 @brief Initializes and returns an instance of the Remote Notifications Controller with the provided parameters.
 
 @param registrationTokenSaver A FIRRegistrationTokenSaving conforming object used to save registration tokens on the application's
                              database.
 */
- (instancetype)init:(id <FIRRegistrationTokenSaving>)registrationTokenSaver;

@end

NS_ASSUME_NONNULL_END
