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

- (void)onAuthStateActive:(NSString *)uid
{
    __weak SessionPreparationViewController * weakSelf = self;
    
    // Fetch the user.
    [self.userFetchingHandler getUserWithIdentifier:uid completionHandler:^(User * _Nullable user, NSError * _Nullable error) {
        if (user == NULL || error != NULL) {
            [weakSelf.sessionEndingHandler signOutUser:^(NSError * _Nullable error) {
                [self.rootNavigator navigateToSignInViewController];
            }];
        } /* if no user record is found or an error occurs while trying to find one */
        else {
            [self.rootNavigator navigateToBottomNavigationViewController];
        } /* if a user record is found */
    }];
}

- (void)attachAuthStateListener
{
    __weak SessionPreparationViewController * weakSelf = self;
    
    // Attach the auth state listener.
    self.authStateListener = [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth * _Nonnull auth, FIRUser * _Nullable user) {
        if (user != NULL) {
            [weakSelf onAuthStateActive:user.uid];
        } /* if a user is currently logged-in */
        else {
            [weakSelf.rootNavigator navigateToSignInViewController];
        } /* if no user is currently logged-in */
    }];
}

@end
