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

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)attachAuthStateListener
{
    __weak SessionPreparationViewController * weakSelf = self;
    
    // Attach the auth state listener.
    self.authStateListener = [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth * _Nonnull auth, FIRUser * _Nullable user) {
        if (user != NULL) {
            [weakSelf.rootNavigator navigateToBottomNavigationViewController];
        } /* if a user is currently logged-in */
        else {
            [weakSelf.rootNavigator navigateToSignInViewController];
        } /* if no user is currently logged-in */
    }];
}

@end
