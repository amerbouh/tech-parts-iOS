//
//  RootNavigationController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootNavigating.h"
#import "TKViewControllerFactory.h"

@class AppDependencyContainer;

NS_ASSUME_NONNULL_BEGIN

@interface RootNavigationController : NSObject <RootNavigating>

/**
 @brief Initializes and returns an instance  of the Root Navigation Controller with the provided parameters.

 @param appDependencyContainer An AppDependencyContainer instance used to produces various dependencies used accross the
                              application.
 @param viewControllerFactory A TKViewControllerFactory conforming object used to created View Controller instances.
 @param window A UIWindow instance used to set the appropriate root view controller of the application.
*/
- (instancetype)initWithAppDependencyContainer:(AppDependencyContainer * _Nonnull)appDependencyContainer viewControllerFactory:(id <TKViewControllerFactory> _Nonnull)viewControllerFactory window:(UIWindow * _Nonnull)window;

@end

NS_ASSUME_NONNULL_END
