//
//  RootNavigationController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "RootNavigationController.h"
#import "AppDependencyContainer.h"

@interface RootNavigationController ()

@property (nonatomic, nonnull) UIWindow * window;
@property (nonatomic, nonnull) AppDependencyContainer * appDependencyContainer;
@property (nonatomic, nonnull) id <TKViewControllerFactory> viewControllerFactory;

@end

@implementation RootNavigationController

#pragma mark - Initialization

- (instancetype)initWithAppDependencyContainer:(AppDependencyContainer *)appDependencyContainer viewControllerFactory:(id<TKViewControllerFactory>)viewControllerFactory window:(UIWindow *)window
{
    self = [super init];
    if (self) {
        _window = window;
        _viewControllerFactory = viewControllerFactory;
        _appDependencyContainer = appDependencyContainer;
    }
    return self;
}

#pragma mark - Methods

- (void)navigateToBottomNavigationViewController
{
    UINavigationController * const projectListViewController = [self.viewControllerFactory makeProjectListViewController];
    UINavigationController * const settingsViewController = [self.viewControllerFactory makeSettingsViewControllerWithSessionManager:[self.appDependencyContainer makeSessionManager]
                                                                                                               rootNavigationHandler:[self.appDependencyContainer makeRootNavigationHandler]];
    
    // Create a new instance of the bottom navigation view controller.
    UIViewController * bottomNavigationViewController = (UIViewController *) [self.viewControllerFactory makeBottomNavigationViewControllerWithProjectListViewController:projectListViewController settingsViewController:settingsViewController];
        
    // Set the Bottom Navigation View Controller instance as the window's root view controller.
    [self.window setRootViewController:bottomNavigationViewController];
    
    // Animate the transition.
    [UIView transitionWithView:self.window duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:NULL completion:NULL];
}

- (void)navigateToSignInViewController
{
    UIViewController * signInViewController = (UIViewController *) [self.viewControllerFactory makeSignInViewControllerWithRootNavigationHandler:[self.appDependencyContainer makeRootNavigationHandler]
                                                                                                      userAuthenticationHandler:[self.appDependencyContainer makeUserAuthenticationHandler]];
    
    // Set the Sign In View Controller instance as the window's root view controller.
    [self.window setRootViewController:signInViewController];
    
    // Animate the transition.
    [UIView transitionWithView:self.window duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:NULL completion:NULL];
}

@end
