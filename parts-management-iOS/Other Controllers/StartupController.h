//
//  StartupController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-05-27.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StartupController : NSObject

/** @brief Runs the startup sequence in order for the application to function correclty. */
- (void)runStartupSequence;

/**
 @brief Initializes and returns an instance  of the Startup Controller with the provided parameters.

 @param appDelegate A UIApplicationDelegate conforming object used access to the application's delegate.
*/
- (instancetype)initWithApp:(UIApplication * _Nonnull)application appDelegate:(id <UIApplicationDelegate>)appDelegate;

@end

NS_ASSUME_NONNULL_END
