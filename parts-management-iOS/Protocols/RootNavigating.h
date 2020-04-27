//
//  RootNavigating.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

NS_ASSUME_NONNULL_BEGIN

@protocol RootNavigating <NSObject>

/** @brief Navigates to the BottomNavigationController and sets it as the window's root view controller. */
- (void)navigateToBottomNavigationViewControllerWithUser:(User * _Nonnull)user;

/** @brief Navigates to the SignInViewController and sets it as the window's root view controller. */
- (void)navigateToSignInViewController;

@end

NS_ASSUME_NONNULL_END
