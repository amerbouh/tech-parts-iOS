//
//  TKViewControllerFactoryImpl.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-15.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "TKViewControllerFactoryImpl.h"
#import "SignInViewController.h"
#import "SettingsTableViewController.h"
#import "BottomNavigationViewController.h"

@implementation TKViewControllerFactoryImpl

#pragma mark - Methods

- (UINavigationController *)makeProjectListViewController
{
    return (UINavigationController *) [[UIStoryboard storyboardWithName:@"Project" bundle:NULL] instantiateInitialViewController];
}

- (UINavigationController *)makeSettingsViewControllerWithSessionManager:(id<SessionManaging>)sessionManager rootNavigationHandler:(id<RootNavigating>)rootNavigationHandler
{
    UINavigationController * const settingsNavigationController = [[UIStoryboard storyboardWithName:@"Setting" bundle:NULL] instantiateInitialViewController];
    
    // Get an instance of the Settings View Controller
    SettingsTableViewController * const settingsViewController = (SettingsTableViewController *) settingsNavigationController.viewControllers[0];
    
    // Initialize the Setting View Controller's properties.
    [settingsViewController setSessionManager:sessionManager];
    [settingsViewController setRootNavigationHandler:rootNavigationHandler];
    
    return settingsNavigationController;
}

- (SignInViewController *)makeSignInViewControllerWithRootNavigationHandler:(id <RootNavigating>)rootNavigationHandler userAuthenticationHandler:(id <UserAuthenticating>)userAuthenticationHandler
{
    SignInViewController * signInViewController = (SignInViewController *) [[UIStoryboard storyboardWithName:@"Authentication" bundle:NULL] instantiateInitialViewController];
    
    // Initialize the view controller's instance variables.
    [signInViewController setRootNavigationHandler:rootNavigationHandler];
    [signInViewController setUserAuthenticationHandler:userAuthenticationHandler];
    
    return signInViewController;
}

- (BottomNavigationViewController *)makeBottomNavigationViewControllerWithProjectListViewController:(UINavigationController *)projectListViewController settingsViewController:(UINavigationController *)settingsViewController
{
    return [[BottomNavigationViewController alloc] initWithProjectListViewController:projectListViewController settingsViewController:settingsViewController];
}

@end
