//
//  SignInViewController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootNavigating.h"
#import "UserAuthenticating.h"
#import "SessionUserFetching.h"
#import "SiriShortcutsAuthorizationManaging.h"
#import "NotificationsAuthorizationManaging.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignInViewController : UIViewController

/** A RootNavigating conforming object responsible for navigation accross the application. */
@property (strong, nonatomic, nonnull) id <RootNavigating> rootNavigationHandler;

/** A UserAuthenticating conforming object responsible for authenticating users. */
@property (strong, nonatomic, nonnull) id <UserAuthenticating> userAuthenticationHandler;

/** A SessionUserFetching conforming object responsible for fetching the profile of the currently signed-in user. */
@property (strong, nonatomic, nonnull) id <SessionUserFetching> sessionUserFetchingHandler;

/** A SiriShortcutsAuthorizationManaging conforming object responsible for handling Siri Shortcuts authorizations. */
@property (strong, nonatomic, nonnull) id <SiriShortcutsAuthorizationManaging> siriShortcutsAuthorizationManager;

/** A SiriShortcutsAuthorizationManaging conforming object responsible for handling notifications authorizations. */
@property (strong, nonatomic, nonnull) id <NotificationsAuthorizationManaging> notificationsAuthorizationManager;

@end

NS_ASSUME_NONNULL_END
