//
//  ForgotPasswordViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-28.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "NSString+Empty.h"
#import "TKRoundedButton.h"
#import "UIViewController+PresentErrorAlertController.h"

@interface ForgotPasswordViewController ()

@property (weak, nonatomic) IBOutlet UILabel * titleLabel;
@property (weak, nonatomic) IBOutlet UILabel * descriptionLabel;

@property (weak, nonatomic) IBOutlet UITextField * emailAddressTextField;
@property (weak, nonatomic) IBOutlet UIButton * sendInstructionsButton;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView * activityIndicatorView;

/** @brief Configures the translations of the text displayed by the View Controller. */
- (void)configureLocalizations;

/** @brief Generates a haptic feedback to communicate to the user that the submit button was taped. */
- (void)generateHapticFeedback;

/** @brief Hides the activity indicator view informing the user of an on-going operation.  */
- (void)hideActivityIndicatorView;

/** @brief Display the activity indicator view informing the user of an on-going operation.  */
- (void)displayActivityIndicatorView;

@end

@implementation ForgotPasswordViewController

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self configureLocalizations];
    [self hideActivityIndicatorView];
    [self.sendInstructionsButton setEnabled:NO];
}

#pragma mark - Methods

- (void)configureLocalizations
{
    [self.titleLabel setText:NSLocalizedString(@"forgotPassword", NULL)];
    [self.descriptionLabel setText:NSLocalizedString(@"passwordResetInstructions", NULL)];
    [self.emailAddressTextField setPlaceholder:NSLocalizedString(@"emailAddress", NULL)];
    [self.sendInstructionsButton setTitle:NSLocalizedString(@"sendInstructions", NULL) forState:UIControlStateNormal];
}

- (void)generateHapticFeedback
{
    UISelectionFeedbackGenerator * feedbackGenerator = [[UISelectionFeedbackGenerator alloc] init];
    [feedbackGenerator selectionChanged];
}

- (IBAction)emailAddressDidChange:(UITextField *)sender
{
    [self.sendInstructionsButton setEnabled:![sender.text isEmpty]];
}

- (void)hideActivityIndicatorView
{
    [self.activityIndicatorView setHidden:YES];
    [self.activityIndicatorView stopAnimating];
    [self.sendInstructionsButton setTitle:NSLocalizedString(@"sendInstructions", NULL) forState:UIControlStateNormal];
}

- (void)displayActivityIndicatorView
{
    [self.activityIndicatorView startAnimating];
    [self.activityIndicatorView setHidden:NO];
    [self.sendInstructionsButton setTitle:NULL forState:UIControlStateNormal];
}

- (IBAction)cancelBarButtonItemTaped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)sendInstructionsButtonTaped:(TKRoundedButton *)sender
{
    [sender setEnabled:NO];
    [self generateHapticFeedback];
    [self displayActivityIndicatorView];
    
    // Dismiss the keyboard.
    [self.view endEditing:YES];
    
    // Create a weak reference to the View Controller to avoid strong reference cycles.
    __weak ForgotPasswordViewController * weakSelf = self;
    
    // Attempt to send the instructions to the user to reset his password.
    [self.userAuthenticator resetPasswordForUserWithEmailAddress:self.emailAddressTextField.text completionHandler:^(NSError * _Nullable error) {
        [weakSelf hideActivityIndicatorView];
        [sender setEnabled:YES];
        
        if (error != NULL) {
            [weakSelf presentErrorAlertControllerWithMessage:error.localizedDescription];
            return;
        } /* if NSError instance is not NULL */
        
        [weakSelf dismissViewControllerAnimated:YES completion:NULL];
    }];
}

@end
