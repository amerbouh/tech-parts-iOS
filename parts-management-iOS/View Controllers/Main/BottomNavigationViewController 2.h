//
//  BottomNavigationViewController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-14.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BottomNavigationViewController : UITabBarController

/**
 @brief Initializes and returns an instance of the Bottom Navigation View Controller with the provided parameters.

 @param projectListViewController A UINavigationController presenting an instance of the project list view controller.
 @param settingsViewController A UINavigationController presenting an instance of the settings view controller.
*/
- (instancetype)initWithProjectListViewController:(UINavigationController * _Nonnull)projectListViewController settingsViewController:(UINavigationController * _Nonnull)settingsViewController;

@end

NS_ASSUME_NONNULL_END
