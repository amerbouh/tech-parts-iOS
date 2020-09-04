//
//  SettingsTableViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-14.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "User.h"
#import "ImageDownloadOperation.h"
#import "UIImageView+ReplaceImage.h"
#import "UIViewController+PresentErrorAlertController.h"

@interface SettingsTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel * fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel * emailAddressLabel;
@property (weak, nonatomic) IBOutlet UIImageView * profileImageView;

@end

@implementation SettingsTableViewController {
    NSOperationQueue * _queue;
    ImageDownloadOperation * _imageDownloadOperation;
}

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return self;
}

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self populateProfileTableViewCell];
    [self.profileImageView.layer setCornerRadius:self.profileImageView.frame.size.height / 2];
}

#pragma mark - Methods

- (void)onSignOutActionClicked
{
    __weak SettingsTableViewController * weakSelf = self;
    
    // Attempt to sign out the user.
    [self.sessionEndingHandler signOutUser:^(NSError * _Nullable error) {
        if (error) {
            [weakSelf presentErrorAlertControllerWithMessage:error.localizedDescription];
            return;
        } /* An error occurred while trying to sign out the user. */
        
        [weakSelf.rootNavigator navigateToSignInViewController];
    }];
}

- (void)populateProfileTableViewCell
{
    NSString * const currentUserId = [self.sessionUserFetchingHandler getCurrentUserId];
    
    // Make sure that the identifier of the current user is not NULL.
    if (currentUserId == NULL) return;
    
    // Obtain a weak reference to the current view controller.
    __weak SettingsTableViewController * const weakSelf = self;
    
    // Fetch the current user's profile.
    [self.userFetchingHandler getUserWithIdentifier:self.sessionUserFetchingHandler.getCurrentUserId completionHandler:^(User * _Nullable user, NSError * _Nullable error) {
        [weakSelf.fullNameLabel setText:user.fullName];
        [weakSelf.emailAddressLabel setText:user.emailAddress];
        
        // Create an NSURL instance of the user's profile image download URL and start a download operation,
        // if applicable.
        if (user.profileImageDownloadURL != NULL)
        {
            NSURL * const profileImageDownloadURL = [NSURL URLWithString:user.profileImageDownloadURL];
        
            // Start an image downloading operation.
            [weakSelf startProfileImageDownloadOperationWithDownloadURL:profileImageDownloadURL];
        }
    }];
}

- (void)presentSignOutAlertController
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"signOut", NULL) message:NSLocalizedString(@"signOutConfirmationMessage", NULL) preferredStyle:UIAlertControllerStyleAlert];
    
    // Get a weak reference to the view controller.
    __weak SettingsTableViewController * weakSelf = self;
    
    // The block of code to execute once we the user taps the confirm action
    // button.
    void (^confirmActionHandler)(UIAlertAction *) = ^(UIAlertAction * action) {
        [weakSelf onSignOutActionClicked];
    };
    
    // Configure the alert controller's actions...
    UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"signOut", NULL) style:UIAlertActionStyleDestructive handler:confirmActionHandler];
    UIAlertAction * dismissAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", NULL) style:UIAlertActionStyleCancel handler:NULL];
    
    // Add the created actions to the alert controller.
    [alertController addAction:confirmAction];
    [alertController addAction:dismissAction];
    
    // Present the alert controller.
    [self presentViewController:alertController animated:YES completion:NULL];
}

- (void)startProfileImageDownloadOperationWithDownloadURL:(NSURL *)imageDownloadURL
{
    __weak SettingsTableViewController * weakSelf = self;
    
    // Initialize the image download operation.
    _imageDownloadOperation = [[ImageDownloadOperation alloc] initWithImageDownloadUrl:imageDownloadURL];
    
    // Initialize a pointer to the class's image download operation instance variable for use
    // in a block.
    ImageDownloadOperation * const imageDownloadOperation = _imageDownloadOperation;
    
    // Define the block to execute once the download operation completes.
    _imageDownloadOperation.completionBlock = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.profileImageView replaceWithImage:imageDownloadOperation.downloadedImage];
        });
    };
    
    // Add the operation to the queue.
    [_queue addOperation:_imageDownloadOperation];
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
