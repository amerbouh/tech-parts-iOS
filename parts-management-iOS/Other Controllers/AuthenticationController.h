//
//  AuthenticationController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FIRUserSaving.h"
#import "FIRUserFetching.h"
#import "UserAuthenticating.h"

NS_ASSUME_NONNULL_BEGIN

@interface AuthenticationController : NSObject <UserAuthenticating>

/**
@brief Initializes and returns an instance  of the Authentication Controller with the provided parameters.

@param userSavingHandler A FIRUserSaving conforming object used to save user profiles on the device's local storage.
@param userFetchingHandler A FIRUserFetching conforming object used to fetch user profiles.
*/
- (instancetype)initWithUserSavingHandler:(id <FIRUserSaving>)userSavingHandler userFetchingHandler:(id <FIRUserFetching>)userFetchingHandler;

@end

NS_ASSUME_NONNULL_END
