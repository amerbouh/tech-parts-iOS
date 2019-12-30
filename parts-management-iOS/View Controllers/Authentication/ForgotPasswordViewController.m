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

/** @brief Configures the translations of the text displayed by the View Controller. */
- (void)configureLocalizations;

/** @brief Generates a haptic feedback to communicate to the user that the submit button was taped. */
- (void)generateHapticFeedback;

@end

@implementation ForgotPasswordViewController

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self configureLocalizations];
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

- (IBAction)cancelBarButtonItemTaped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)sendInstructionsButtonTaped:(TKRoundedButton *)sender
{
    [sender setEnabled:NO];
    [self generateHapticFeedback];
    
    // Dismiss the keyboard.
    [self.view endEditing:YES];
    
    // Create a weak reference to the View Controller to avoid strong reference cycles.
    __weak ForgotPasswordViewController * weakSelf = self;
    
    // Attempt to send the instructions to the user to reset his password.
    [self.userAuthenticator resetPasswordForUserWithEmailAddress:self.emailAddressTextField.text completionHandler:^(NSError * _Nullable error) {
        if (error != NULL) {
            [weakSelf presentErrorAlertControllerWithMessage:error.localizedDescription];
        } /* if NSError instance is not NULL */
        
        [weakSelf dismissViewControllerAnimated:YES completion:NULL];
    }];
}

@end
