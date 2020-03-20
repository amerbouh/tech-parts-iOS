//
//  TKViewControllerFactory.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-15.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootNavigating.h"
#import "UserAuthenticating.h"

@class SignInViewController;
@class BottomNavigationViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol TKViewControllerFactory <NSObject>

/** @brief Initializes and returns an instance of the Bottom Navigation View Controller with the provided parameters. */
- (BottomNavigationViewController * _Nonnull)makeBottomNavigationViewController;

/**
 @brief Initializes and returns an instance of the Sign In View Controller with the provided parameters.
 
 @param rootNavigationHandler A RootNavigating conforming object used to handle navigation.
 @param userAuthenticationHandler A UserAuthenticating conforming object used to handle authentication.
 */
- (SignInViewController * _Nonnull)makeSignInViewControllerWithRootNavigationHandler:(id <RootNavigating> _Nonnull)rootNavigationHandler userAuthenticationHandler:(id <UserAuthenticating> _Nonnull)userAuthenticationHandler;

@end

NS_ASSUME_NONNULL_END
