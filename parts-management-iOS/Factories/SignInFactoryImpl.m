//
//  SignInFactoryImpl.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-08-24.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "SignInFactoryImpl.h"
#import "RootNavigating.h"
#import "UserAuthenticating.h"
#import "SessionUserFetching.h"
#import "AppDependencyContainer.h"
#import "SiriShortcutsAuthorizationManaging.h"
#import "NotificationsAuthorizationManaging.h"

@interface SignInFactoryImpl ()

@property (strong, nonatomic, nonnull) AppDependencyContainer * appDependencyContainer;

@end

@implementation SignInFactoryImpl

#pragma mark - Initialization

- (instancetype)initWithAppDependencyContainer:(AppDependencyContainer *)appDependencyContainer
{
    self = [super init];
    if (self) {
        _appDependencyContainer = appDependencyContainer;
    }
    return self;
}

#pragma mark - Methods

- (id <RootNavigating>)makeRootNavigationHandler
{
    return _appDependencyContainer.makeRootNavigationHandler;
}

- (id <UserAuthenticating>)makeUserAuthenticationHandler
{
    return _appDependencyContainer.makeUserAuthenticationHandler;
}

- (id <SessionUserFetching>)makeSessionUserFetchingHandler
{
    return _appDependencyContainer.makeSessionUserFetchingHandler;
}

- (id <SiriShortcutsAuthorizationManaging>)makeSiriShortcutsAuthorizationManager
{
    return _appDependencyContainer.makeSiriShorcutsAuthorizationManager;
}

- (id <NotificationsAuthorizationManaging>)makeNotificationsAuthorizationManager
{
    return _appDependencyContainer.makeNotificationsAuthorizationManager;
}

@end
