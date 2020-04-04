//
//  AppDependencyContainer.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-15.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "AppDependencyContainer.h"
#import "UserRepository.h"
#import "SessionController.h"
#import "RootNavigationController.h"
#import "AuthenticationController.h"
#import "TKViewControllerFactoryImpl.h"

@implementation AppDependencyContainer {
    RLMRealm * _realm;
    UIWindow * _window;
    FIRFirestore * _firestore;
}

#pragma mark - Initialization

- (instancetype)initWithRealm:(RLMRealm *)realm firestore:(FIRFirestore *)firestore window:(nonnull UIWindow *)window
{
    self = [super init];
    if (self) {
        _realm = realm;
        _window = window;
        _firestore = firestore;
    }
    return self;
}

#pragma mark - Methods

- (id<SessionManaging>)makeSessionManager
{
    UserRepository * userRepository = [[UserRepository alloc] initWithRealm:_realm firestore:_firestore];
    
    // Return a newly created instance of the Session Controller class.
    return [[SessionController alloc] initWithUserDeletionHandler:userRepository];
}

- (id<RootNavigating>)makeRootNavigationHandler
{
    TKViewControllerFactoryImpl * viewControllerFactory = [TKViewControllerFactoryImpl new];
    
    // Return a newly created instance of the Root Navigation controller class.
    return [[RootNavigationController alloc] initWithAppDependencyContainer:self
                                                      viewControllerFactory:viewControllerFactory
                                                                     window:_window];
}

- (id<FIRUserFetching>)makeUserFetchingHandler
{
    return [[UserRepository alloc] initWithRealm:_realm firestore:_firestore];
}

- (id<UserAuthenticating>)makeUserAuthenticationHandler
{
    UserRepository * userRepository = [[UserRepository alloc] initWithRealm:_realm firestore:_firestore];
    
    // Return a newly created instance of the AuthenticationController class.
    return [[AuthenticationController alloc] initWithUserSavingHandler:userRepository
                                                   userFetchingHandler:userRepository];
}

@end