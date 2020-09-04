//
//  SignInFactory.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-09-03.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootNavigating.h"
#import "UserAuthenticating.h"
#import "SessionUserFetching.h"
#import "SiriShortcutsAuthorizationManaging.h"
#import "NotificationsAuthorizationManaging.h"


NS_ASSUME_NONNULL_BEGIN

@protocol SignInFactory <NSObject>

- (id <RootNavigating>)makeRootNavigationHandler;
- (id <UserAuthenticating>)makeUserAuthenticationHandler;
- (id <SessionUserFetching>)makeSessionUserFetchingHandler;
- (id <SiriShortcutsAuthorizationManaging>)makeSiriShortcutsAuthorizationManager;
- (id <NotificationsAuthorizationManaging>)makeNotificationsAuthorizationManager;

@end

NS_ASSUME_NONNULL_END
