//
//  BottomNavigationViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-14.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "BottomNavigationViewController.h"

@interface BottomNavigationViewController ()

- (void)configureTabBarItems;

@end

@implementation BottomNavigationViewController

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self configureTabBarItems];
}

#pragma mark - Methods

- (void)configureTabBarItems
{
    UINavigationController * projectListNavigationController = (UINavigationController *) self.viewControllers[0];
    UINavigationController * settingsNavigationController = (UINavigationController *) self.viewControllers[1];
    
    // Get an instance of the view controllers displayed by the tab bar's navigation controllers.
    UIViewController * projectListViewController = projectListNavigationController.viewControllers[0];
    UIViewController * settingsViewController = settingsNavigationController.viewControllers[0];
    
    // Configure the view controllers' tab bar items.
    [projectListViewController setTitle:NSLocalizedString(@"projects", NULL)];
    [projectListNavigationController.tabBarItem setImage:[UIImage imageNamed:@"documents"]];
    [settingsViewController setTitle:NSLocalizedString(@"settings", NULL)];
    [settingsNavigationController.tabBarItem setImage:[UIImage imageNamed:@"settings"]];
}

@end
