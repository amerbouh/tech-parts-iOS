//
//  SignUpProcessCompletionViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-07-01.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "SignUpProcessCompletionViewController.h"
#import "NSString+Empty.h"
#import "UIViewController+PresentErrorAlertController.h"

@interface SignUpProcessCompletionViewController ()

@property (weak, nonatomic) IBOutlet UILabel * titleLabel;
@property (weak, nonatomic) IBOutlet UILabel * subtitleLabel;

@property (weak, nonatomic) IBOutlet UITextField * firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField * lastNameTextField;

@property (weak, nonatomic) IBOutlet UIButton * completeProfileButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView * activityIndicatorView;

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Do any additional setup before the view appears.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(formInputsDidChangeValue) name:UITextFieldTextDidChangeNotification object:NULL];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Do any additional setup before the view disappears.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Methods

- (void)formInputsDidChangeValue
{
    if ([self.firstNameTextField.text isEmpty] || [self.lastNameTextField.text isEmpty]) {
        [self.completeProfileButton setEnabled:NO];
    } /* if form contains empty text field */
    else {
        [self.completeProfileButton setEnabled:YES];
    } /* if form does not contain empty text field */
}


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
    NSString * const currentUserId = [self.sessionUserFetchingHandler getCurrentUserId];
    
    // Make sure that we know the identifier of the currently authenticated user.
    if (currentUserId == NULL) {
        return;
    }
    
    // Display an activity indicator view and disable the button used to trigger
    // the action.
    [self displayActivityIndicatorView];
    [self.completeProfileButton setEnabled:NO];
    
    // Dismiss the keyboard.
    [self.view endEditing:YES];
    
    // Create a weak reference to the View Controller to avoid strong reference cycles.
    __weak SignUpProcessCompletionViewController * weakSelf = self;
    
    // Attempt to complete the sign up process.
    [self.userAuthenticationHandler completeSignUpProcessForUserWithId:currentUserId emailAddress:self.emailAddress firstName:self.firstNameTextField.text lastName:self.lastNameTextField.text completionHandler:^(NSError * _Nullable error) {
        if (error != NULL) {
            [weakSelf presentErrorAlertControllerWithMessage:error.localizedRecoverySuggestion];
        } /* if NSError instance is not NULL */
        else {
            [weakSelf performSegueWithIdentifier:@"UnwindToSignInViewControllerSegue" sender:weakSelf];
        } /* if NSError instance is NULL */
    }];
}

@end
