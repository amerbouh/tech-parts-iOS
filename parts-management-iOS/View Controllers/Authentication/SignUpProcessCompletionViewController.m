//
//  SignUpProcessCompletionViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-07-01.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "SignUpProcessCompletionViewController.h"

@interface SignUpProcessCompletionViewController ()

@property (weak, nonatomic) IBOutlet UILabel * titleLabel;
@property (weak, nonatomic) IBOutlet UILabel * subtitleLabel;

@property (weak, nonatomic) IBOutlet UITextField * firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField * lastNameTextField;

@property (weak, nonatomic) IBOutlet UIButton * completeProfileButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView * activityIndicatorView;

/** @brief Configures the translations of the text displayed by the View Controller. */
- (void)configureLocalizations;

/** @brief Hides the activity indicator view informing the user of an on-going operation.  */
- (void)hideActivityIndicatorView;

/** @brief Display the activity indicator view informing the user of an on-going operation.  */
- (void)displayActivityIndicatorView;

@end

@implementation SignUpProcessCompletionViewController

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.completeProfileButton setEnabled:NO];
    [self configureLocalizations];
    [self hideActivityIndicatorView];
}

#pragma mark - Methods

- (void)configureLocalizations
{
    [self.titleLabel setText:NSLocalizedString(@"completeProfile", NULL)];
    [self.subtitleLabel setText:NSLocalizedString(@"completeProfileDescription", NULL)];
    [self.firstNameTextField setPlaceholder:NSLocalizedString(@"firstName", NULL)];
    [self.lastNameTextField setPlaceholder:NSLocalizedString(@"lastName", NULL)];
}

- (void)hideActivityIndicatorView
{
    [self.activityIndicatorView setHidden:YES];
    [self.activityIndicatorView stopAnimating];
    [self.completeProfileButton setTitle:NSLocalizedString(@"completeProfile", NULL) forState:UIControlStateNormal];
}

- (void)displayActivityIndicatorView
{
    [self.activityIndicatorView startAnimating];
    [self.activityIndicatorView setHidden:NO];
    [self.completeProfileButton setTitle:NULL forState:UIControlStateNormal];
}

- (IBAction)cancelBarButtonItemTaped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)completionProfileButtonTaped:(id)sender
{
    [self displayActivityIndicatorView];
    
    // Dismiss the keyboard.
    [self.view endEditing:YES];
    
    // Create a weak reference to the View Controller to avoid strong reference cycles.
    __weak SignUpProcessCompletionViewController * weakSelf = self;
    
    // Attempt to complete the sign up process.
    [self.userAuthenticationHandler completeSignUpProcessForUserWithId:@"OwuzT21RZaY5fDVF5JrCDODDIOq2" emailAddress:@"anas.merbouh@outlook.com" firstName:self.firstNameTextField.text lastName:self.lastNameTextField.text completionHandler:^(NSError * _Nullable error) {
        if (error != NULL) {
            
        } /* if NSError instance is not NULL */
        else {
            
        } /* if NSError instance is NULL */
    }];
}

@end
