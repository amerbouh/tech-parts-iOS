//
//  TKViewControllerFactoryImpl.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-15.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "TKViewControllerFactoryImpl.h"
#import "SignInViewController.h"
#import "AuthorizationController.h"
#import "ProjectListViewController.h"
#import "SettingsTableViewController.h"
#import "BottomNavigationViewController.h"

@implementation TKViewControllerFactoryImpl

#pragma mark - Methods

- (UINavigationController *)makeProjectListViewControllerWithUser:(User *)user
{
    UINavigationController * const projectListNavigationController = (UINavigationController *) [[UIStoryboard storyboardWithName:@"Project" bundle:NULL] instantiateInitialViewController];
    
    // Get an instance of the Project List View Controller.
    ProjectListViewController * const projectListViewController = (ProjectListViewController *) projectListNavigationController.viewControllers[0];
    
    // Initialize the Project List View Controller's properties.
    [projectListViewController setAuthorizationManager:[[AuthorizationController alloc] initWithUser:user]];
    
    return projectListNavigationController;
}

- (UINavigationController *)makeSettingsViewControllerWithSessionManager:(id <SessionManaging>)sessionManager userFetchingHandler:(id <FIRUserFetching>)userFetchingHandler rootNavigationHandler:(id <RootNavigating>)rootNavigationHandler
{
    UINavigationController * const settingsNavigationController = [[UIStoryboard storyboardWithName:@"Setting" bundle:NULL] instantiateInitialViewController];
    
    // Get an instance of the Settings View Controller
    SettingsTableViewController * const settingsViewController = (SettingsTableViewController *) settingsNavigationController.viewControllers[0];
    
    // Initialize the Setting View Controller's properties.
    [settingsViewController setSessionManager:sessionManager];
    [settingsViewController setUserFetchingHandler:userFetchingHandler];
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
