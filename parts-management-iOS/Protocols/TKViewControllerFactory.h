//
//  TKViewControllerFactory.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-15.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootNavigating.h"
#import "SessionManaging.h"
#import "UserAuthenticating.h"

@class SignInViewController;
@class UINavigationController;
@class BottomNavigationViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol TKViewControllerFactory <NSObject>

- (UINavigationController * _Nonnull)makeProjectListViewController;
- (UINavigationController * _Nonnull)makeSettingsViewControllerWithSessionManager:(id <SessionManaging>)sessionManager rootNavigationHandler:(id <RootNavigating>)rootNavigationHandler;

/**
 @brief Initializes and returns an instance of the Sign In View Controller with the provided parameters.
 
 @param rootNavigationHandler A RootNavigating conforming object used to handle navigation.
 @param userAuthenticationHandler A UserAuthenticating conforming object used to handle authentication.
 */
- (SignInViewController * _Nonnull)makeSignInViewControllerWithRootNavigationHandler:(id <RootNavigating> _Nonnull)rootNavigationHandler userAuthenticationHandler:(id <UserAuthenticating> _Nonnull)userAuthenticationHandler;

/**
 @brief Initializes and returns an instance of the Bottom Navigation View Controller with the provided parameters.
 
 @param projectListViewController A UINavigationController presenting an instance of the project list view controller.
 @param settingsViewController A UINavigationController presenting an instance of the settings view controller.
 */
- (BottomNavigationViewController * _Nonnull)makeBottomNavigationViewControllerWithProjectListViewController:(UINavigationController *)projectListViewController settingsViewController:(UINavigationController *)settingsViewController;

@end

NS_ASSUME_NONNULL_END
