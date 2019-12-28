//
//  RootNavigationController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootNavigating.h"

NS_ASSUME_NONNULL_BEGIN

@interface RootNavigationController : NSObject <RootNavigating>

/** @brief Initializes and returns the shared instance of the RootNavigationController class. */
+ (instancetype)getDefault;

/** @brief Sets the window used by the controller to display View Controller instances. */
- (void)setApplicationWindow:(UIWindow *)applicationWindow;

@end

NS_ASSUME_NONNULL_END
