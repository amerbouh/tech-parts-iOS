//
//  RootNavigationController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "RootNavigationController.h"
#import "SignInViewController.h"

@interface RootNavigationController ()

@property (strong, nonatomic, nonnull) UIWindow * window;

@end

@implementation RootNavigationController

#pragma mark - Methods

- (void)setApplicationWindow:(UIWindow *)applicationWindow
{
    self.window = applicationWindow;
}

- (void)navigateToBottomNavigationViewController
{
    UIViewController * bottomNavigationViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"BottomNavigationViewController"];
        
    // Set the Sign In View Controller instance as the window's root view controller.
    [self.window setRootViewController:bottomNavigationViewController];
    
    // Animate the transition.
    [UIView transitionWithView:self.window duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:NULL completion:NULL];
}

- (void)navigateToSignInViewControllerUsingRootNavigator:(id<RootNavigating>)rootNavigator
{
    SignInViewController * signInViewController = (SignInViewController *) [[UIStoryboard storyboardWithName:@"Authentication" bundle:NULL] instantiateInitialViewController];
    [signInViewController setRootNavigator:rootNavigator];
    
    // Set the Sign In View Controller instance as the window's root view controller.
    [self.window setRootViewController:signInViewController];
    
    // Animate the transition.
    [UIView transitionWithView:self.window duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:NULL completion:NULL];
}

#pragma mark - Convenience methods

+ (instancetype)getDefault
{
    static RootNavigationController * sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    // Called only if an instance of the controller doesn't already
    // exist.
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RootNavigationController alloc] init];
        // Do any other initialisation stuff here
    });
    
    return sharedInstance;
}

@end
