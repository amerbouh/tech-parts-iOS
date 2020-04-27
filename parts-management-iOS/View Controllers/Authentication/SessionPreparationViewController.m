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

/** @brief Loads the profile of the user with the given identifier.

    @param uid An NSString representing the identifier of the user.
 */
- (void)loadUserForUid:(NSString *)uid;

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

- (void)loadUserForUid:(NSString *)uid
{
    __weak SessionPreparationViewController * weakSelf = self;
    
    // Load the appropriate user.
    [self.userFetchingHandler getUserWithIdentifier:uid completionHandler:^(User * _Nullable user, NSError * _Nullable error) {
        if (error != NULL) {
            [weakSelf.rootNavigator navigateToSignInViewController];
        } /* An error occurred while trying to fetch the user. */
        else {
            [weakSelf.rootNavigator navigateToBottomNavigationViewControllerWithUser:user];
        }
    }];
}

- (void)attachAuthStateListener
{
    __weak SessionPreparationViewController * weakSelf = self;
    
    // Attach the auth state listener.
    self.authStateListener = [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth * _Nonnull auth, FIRUser * _Nullable user) {
        if (user != NULL) {
            [weakSelf loadUserForUid:user.uid];
        } /* if a user is currently logged-in */
        else {
            [weakSelf.rootNavigator navigateToSignInViewController];
        } /* if no user is currently logged-in */
    }];
}

@end
