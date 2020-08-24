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

- (UINavigationController *)makeSettingsViewControllerWithSessionEndingHandler:(id<SessionEnding>)sessionEndingHandler sessionUserFetchingHandler:(id<SessionUserFetching>)sessionUserFetchingHandler userFetchingHandler:(id<FIRUserFetching>)userFetchingHandler rootNavigationHandler:(id<RootNavigating>)rootNavigationHandler
{
    UINavigationController * const settingsNavigationController = [[UIStoryboard storyboardWithName:@"Setting" bundle:NULL] instantiateInitialViewController];
    
    // Get an instance of the Settings View Controller
    SettingsTableViewController * const settingsViewController = (SettingsTableViewController *) settingsNavigationController.viewControllers[0];
    
    // Initialize the Setting View Controller's properties.
    [settingsViewController setRootNavigator:rootNavigationHandler];
    [settingsViewController setUserFetchingHandler:userFetchingHandler];
    [settingsViewController setSessionEndingHandler:sessionEndingHandler];
    [settingsViewController setSessionUserFetchingHandler:sessionUserFetchingHandler];
    
    return settingsNavigationController;
}

- (BottomNavigationViewController *)makeBottomNavigationViewControllerWithProjectListViewController:(UINavigationController *)projectListViewController settingsViewController:(UINavigationController *)settingsViewController
{
    return [[BottomNavigationViewController alloc] initWithProjectListViewController:projectListViewController settingsViewController:settingsViewController];
}

- (SignInViewController *)makeSignInViewControllerWithRootNavigationHandler:(id<RootNavigating>)rootNavigationHandler userAuthenticationHandler:(id<UserAuthenticating>)userAuthenticationHandler sessionUserFetchingHandler:(id<SessionUserFetching>)sessionUserFetchingHandler siriShortcutsAuthorizationManager:(id<SiriShortcutsAuthorizationManaging>)siriShortcutsAuthorizationManager notificationsAuthorizationManager:(id<NotificationsAuthorizationManaging>)notificationsAuthorizationManager
{
    SignInViewController * signInViewController = (SignInViewController *) [[UIStoryboard storyboardWithName:@"Authentication" bundle:NULL] instantiateInitialViewController];
    
    // Initialize the view controller's instance variables.
    [signInViewController setRootNavigationHandler:rootNavigationHandler];
    [signInViewController setUserAuthenticationHandler:userAuthenticationHandler];
    [signInViewController setSessionUserFetchingHandler:sessionUserFetchingHandler];
    [signInViewController setSiriShortcutsAuthorizationManager:siriShortcutsAuthorizationManager];
    [signInViewController setNotificationsAuthorizationManager:notificationsAuthorizationManager];
    
    return signInViewController;
}

@end
