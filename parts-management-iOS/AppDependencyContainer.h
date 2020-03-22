//
//  AppDependencyContainer.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-15.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootNavigating.h"
#import "SessionManaging.h"
#import "UserAuthenticating.h"

@class RLMRealm;
@class UIWindow;
@class FIRFirestore;

NS_ASSUME_NONNULL_BEGIN

@interface AppDependencyContainer : NSObject

- (id <SessionManaging>)makeSessionManager;
- (id <RootNavigating>)makeRootNavigationHandler;
- (id <UserAuthenticating>)makeUserAuthenticationHandler;

/**
 @brief Initializes and returns an instance of the App Dependency Container with the provided parameters.

 @param realm A RLMRealm instance representing the object used to read from the device's local storage.
 @param window A UIWindow instance representing the object used to dispatch events to the application's views.
 @param firestore A FIRFirestore instance representing the object used to interact with the application's database.
 
*/
- (instancetype)initWithRealm:(RLMRealm * _Nonnull)realm firestore:(FIRFirestore * _Nonnull)firestore window:(UIWindow *)window;

@end

NS_ASSUME_NONNULL_END
