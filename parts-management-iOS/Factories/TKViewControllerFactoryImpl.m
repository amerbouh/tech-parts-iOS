//
//  TKViewControllerFactoryImpl.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-15.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "TKViewControllerFactoryImpl.h"
#import "SignInViewController.h"
#import "BottomNavigationViewController.h"

@implementation TKViewControllerFactoryImpl

#pragma mark - Methods

- (BottomNavigationViewController *)makeBottomNavigationViewController
{
    return (BottomNavigationViewController *) [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"BottomNavigationViewController"];
}

- (SignInViewController *)makeSignInViewControllerWithRootNavigationHandler:(id <RootNavigating>)rootNavigationHandler userAuthenticationHandler:(id <UserAuthenticating>)userAuthenticationHandler
{
    SignInViewController * signInViewController = (SignInViewController *) [[UIStoryboard storyboardWithName:@"Authentication" bundle:NULL] instantiateInitialViewController];
    
    // Initialize the view controller's instance variables.
    [signInViewController setRootNavigationHandler:rootNavigationHandler];
    [signInViewController setUserAuthenticationHandler:userAuthenticationHandler];
    
    return signInViewController;
}

@end
