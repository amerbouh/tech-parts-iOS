//
//  SessionPreparationViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "SessionPreparationViewController.h"
#import <FirebaseAuth/FirebaseAuth.h>

@interface SessionPreparationViewController ()

@property (nonnull) FIRAuthStateDidChangeListenerHandle authStateListener;

/** @brief Attaches the View Controller's FIRAuthStateDidChangeListenerHandle instance. */
- (void)attachAuthStateListener;

/** @brief Navigates the user to the Sign In View Controller. */
- (void)navigateToSignInViewController;

/** @brief Navigates the user to the Bottom Navigation View Controller. */
- (void)navigateToBottomNavigationViewController;

@end

@implementation SessionPreparationViewController

#pragma mark - View's lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Do any additional setup before the view appears.
    [self attachAuthStateListener];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Do any additional setup before the view disappears.
    [[FIRAuth auth] removeAuthStateDidChangeListener:self.authStateListener];
}

#pragma mark - Methods

- (void)attachAuthStateListener
{
    __weak SessionPreparationViewController * weakSelf = self;
    
    // Attach the auth state listener.
    self.authStateListener = [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth * _Nonnull auth, FIRUser * _Nullable user) {
        if (user != NULL) {
            [weakSelf navigateToBottomNavigationViewController];
        } /* if a user is currently logged-in */
        else {
            [weakSelf navigateToSignInViewController];
        } /* if no user is currently logged-in */
    }];
}

- (void)navigateToSignInViewController
{
    UIViewController * signInViewController = [[UIStoryboard storyboardWithName:@"Authentication" bundle:NULL] instantiateInitialViewController];
    
    // Get the application's window.
    UIWindow * window = UIApplication.sharedApplication.keyWindow;
    
    // Set the Sign In View Controller instance as the window's root view controller.
    [window setRootViewController:signInViewController];
    
    // Animate the transition.
    [UIView transitionWithView:window duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:NULL completion:NULL];
}

- (void)navigateToBottomNavigationViewController
{
    UIViewController * bottomNavigationViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"BottomNavigationViewController"];
    
    // Get the application's window.
    UIWindow * window = UIApplication.sharedApplication.keyWindow;
    
    // Set the Sign In View Controller instance as the window's root view controller.
    [window setRootViewController:bottomNavigationViewController];
    
    // Animate the transition.
    [UIView transitionWithView:window duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:NULL completion:NULL];
}

@end
