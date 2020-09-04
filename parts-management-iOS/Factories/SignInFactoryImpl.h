//
//  SignInFactoryImpl.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-08-24.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignInFactory.h"

@class AppDependencyContainer;

NS_ASSUME_NONNULL_BEGIN

@interface SignInFactoryImpl : NSObject <SignInFactory>

/**
 @brief Initializes and returns an instance of the User Repository with the provided parameters.

 @param appDependencyContainer An AppDependencyContainer instance representing the object used to
                              retrieve the application's dependencies.
*/
- (instancetype)initWithAppDependencyContainer:(AppDependencyContainer *)appDependencyContainer;

@end

NS_ASSUME_NONNULL_END
