//
//  SettingsTableViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-14.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "UIViewController+PresentErrorAlertController.h"

@interface SettingsTableViewController ()

- (void)onSignOutActionClicked;
- (void)presentSignOutAlertController;

@end

@implementation SettingsTableViewController

#pragma mark - Methods

- (void)onSignOutActionClicked
{
    __weak SettingsTableViewController * weakSelf = self;
    
    // Attempt to sign out the user.
    [self.sessionManager signOutUser:^(NSError * _Nullable error) {
        if (error) {
            [weakSelf presentErrorAlertControllerWithMessage:error.localizedDescription];
            return;
        } /* An error occurred while trying to sign out the user. */
        
        [weakSelf.rootNavigationHandler navigateToSignInViewController];
    }];
}

- (void)presentSignOutAlertController
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"signOut", NULL) message:NSLocalizedString(@"signOutConfirmationMessage", NULL) preferredStyle:UIAlertControllerStyleAlert];
    
    // Get a weak reference to the view controller.
    __weak SettingsTableViewController * weakSelf = self;
    
    // Configure the alert controller's actions...
    UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"signOut", NULL) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf onSignOutActionClicked];[weakSelf.sessionManager signOutUser:^(NSError * _Nullable error) {
            if (error) {
                return;
            } /* An error occurred while trying to sign out the user. */
            
            [weakSelf.rootNavigationHandler navigateToSignInViewController];
        }];
    }];
    UIAlertAction * dismissAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", NULL) style:UIAlertActionStyleCancel handler:NULL];
    
    // Add the created actions to the alert controller.
    [alertController addAction:confirmAction];
    [alertController addAction:dismissAction];
    
    // Present the alert controller.
    [self presentViewController:alertController animated:YES completion:NULL];
}

#pragma mark - Table View delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        [self presentSignOutAlertController];
    } /* Sign Out Table View row was selected */
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
