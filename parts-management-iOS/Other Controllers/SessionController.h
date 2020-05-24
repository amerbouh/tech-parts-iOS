//
//  SessionController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-14.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SessionManaging.h"
#import "FIRUserDeleting.h"
#import "FIRRegistrationTokenDeleting.h"

NS_ASSUME_NONNULL_BEGIN

@interface SessionController : NSObject <SessionManaging>

/**
 @brief Initializes and returns an instance  of the Session Controller with the provided parameters.

 @param userDeletionHandler                              A FIRUserDeleting conforming object used to delete user profiles from the device's local storage
 @param registrationTokenDeletionHandler A FIRRegistrationTokenDeleting conforming object used to delete registration tokens from the Realtime Database.
*/
- (instancetype)initWithUserDeletionHandler:(id <FIRUserDeleting>)userDeletionHandler registrationTokenDeletionHandler:(id <FIRRegistrationTokenDeleting>)registrationTokenDeletionHandler;

@end

NS_ASSUME_NONNULL_END
