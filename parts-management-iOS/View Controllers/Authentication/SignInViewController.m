//
//  SignInViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "SignInViewController.h"
#import "NSString+Empty.h"
#import "TKRoundedButton.h"
#import "AuthenticationController.h"
#import "ForgotPasswordViewController.h"
#import "UIViewController+PresentErrorAlertController.h"

@interface SignInViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView * scrollView;

@property (weak, nonatomic) IBOutlet UITextField * emailAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField * passwordTextField;

@property (weak, nonatomic) IBOutlet TKRoundedButton * signInButton;
@property (weak, nonatomic) IBOutlet TKRoundedButton * signUpButton;

@property (weak, nonatomic) IBOutlet UIButton * forgotPasswordButton;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView * activityIndicatorView;

/** @brief Generates a haptic feedback to communicate to the user that the submit button was taped. */
- (void)generateHapticFeedback;

/** @brief Updates the state of the sign in button according to the inputs of the form. */
- (void)formInputsDidChangeValue;

/** @brief Configures the translations of the text displayed by the View Controller. */
- (void)configureLocalizations;

/** @brief Hides the activity indicator view informing the user of an on-going operation.  */
- (void)hideActivityIndicatorView;

/** @brief Display the activity indicator view informing the user of an on-going operation.  */
- (void)displayActivityIndicatorView;

/** @brief Updates the layout of the view managed by the View Controller according to the keyboard's visibility.  */
- (void)didReceiveKeyboardNotification:(NSNotification *)notification;

@end

@implementation SignInViewController

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.signInButton setEnabled:NO];
    [self configureLocalizations];
    [self hideActivityIndicatorView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Do any additional setup before the view appears.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveKeyboardNotification:) name:UIKeyboardWillShowNotification object:NULL];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveKeyboardNotification:) name:UIKeyboardWillHideNotification object:NULL];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(formInputsDidChangeValue) name:UITextFieldTextDidChangeNotification object:NULL];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Do any additional setup before the view disappears.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Methods

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)generateHapticFeedback
{
    UISelectionFeedbackGenerator * feedbackGenerator = [[UISelectionFeedbackGenerator alloc] init];
    [feedbackGenerator selectionChanged];
}

- (void)formInputsDidChangeValue
{
    if ([self.emailAddressTextField.text isEmpty] || [self.passwordTextField.text isEmpty]) {
        [self.signInButton setEnabled:NO];
    } /* if form contains empty text field */
    else {
        [self.signInButton setEnabled:YES];
    } /* if form does not contain empty text field */
}

- (void)configureLocalizations
{
    [self.passwordTextField setPlaceholder:NSLocalizedString(@"password", NULL)];
    [self.emailAddressTextField setPlaceholder:NSLocalizedString(@"emailAddress", NULL)];
    [self.signInButton setTitle:NSLocalizedString(@"signIn", NULL) forState:UIControlStateNormal];
    [self.signUpButton setTitle:NSLocalizedString(@"signUp", NULL) forState:UIControlStateNormal];
    [self.forgotPasswordButton setTitle:NSLocalizedString(@"forgotPassword", NULL) forState:UIControlStateNormal];
}

- (void)hideActivityIndicatorView
{
    [self.activityIndicatorView setHidden:YES];
    [self.activityIndicatorView stopAnimating];
    [self.signInButton setTitle:NSLocalizedString(@"signIn", NULL) forState:UIControlStateNormal];
}

- (void)displayActivityIndicatorView
{
    [self.activityIndicatorView startAnimating];
    [self.activityIndicatorView setHidden:NO];
    [self.signInButton setTitle:NULL forState:UIControlStateNormal];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveKeyboardNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:UIKeyboardWillHideNotification]) {
        self.scrollView.contentInset = UIEdgeInsetsZero;
    } /* if the notification's name is UIKeyboardWillHideNotification */
    else {
        CGRect keyboardFrame = [[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        self.scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardFrame.size.height, 0.0);
    } /* if the notification's name is not UIKeyboardWillHideNotification */
}

- (IBAction)signInButtonTaped:(TKRoundedButton *)sender
{
    [sender setEnabled:NO];
    [self generateHapticFeedback];
    [self displayActivityIndicatorView];
    
    // Dismiss the keyboard.
    [self.view endEditing:YES];
    
    // Create a weak reference to the View Controller to avoid strong reference cycles.
    __weak SignInViewController * weakSelf = self;
    
    // Attempt to authenticate the user.
    [self.userAuthenticationHandler signInUserWithEmailAddress:self.emailAddressTextField.text password:self.passwordTextField.text completionHandler:^(NSError * _Nullable error) {
        [weakSelf hideActivityIndicatorView];
        [sender setEnabled:YES];
        
        if (error != NULL) {
            [weakSelf presentErrorAlertControllerWithMessage:error.localizedDescription];
            return;
        } /* if NSError instance is not NULL */
        
        [weakSelf.rootNavigationHandler navigateToBottomNavigationViewController];
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowForgotPasswordViewControllerSegue"]) {
        UINavigationController * navigationController = (UINavigationController *) segue.destinationViewController;
        ForgotPasswordViewController * forgotPasswordViewController = (ForgotPasswordViewController *) navigationController.visibleViewController;
        forgotPasswordViewController.userAuthenticator = self.userAuthenticationHandler;
    }
}

@end
