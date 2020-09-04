//
//  SignInViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "SignInViewController.h"
#import "RootNavigating.h"
#import "NSString+Empty.h"
#import "TKRoundedButton.h"
#import "UserAuthenticating.h"
#import "SiriShortcutsAuthorizationManaging.h"
#import "NotificationsAuthorizationManaging.h"
#import "ForgotPasswordViewController.h"
#import "SignUpProcessCompletionViewController.h"
#import "UIViewController+PresentErrorAlertController.h"

@interface SignInViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView * scrollView;

@property (weak, nonatomic) IBOutlet UITextField * emailAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField * passwordTextField;

@property (weak, nonatomic) IBOutlet TKRoundedButton * signInButton;
@property (weak, nonatomic) IBOutlet TKRoundedButton * signUpButton;

@property (weak, nonatomic) IBOutlet UIButton * forgotPasswordButton;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView * activityIndicatorView;

/** A RootNavigating conforming object responsible for navigation accross the application. */
@property (strong, nonatomic, nonnull) id <RootNavigating> rootNavigationHandler;

/** A UserAuthenticating conforming object responsible for authenticating users. */
@property (strong, nonatomic, nonnull) id <UserAuthenticating> userAuthenticationHandler;

/** A SiriShortcutsAuthorizationManaging conforming object responsible for handling Siri Shortcuts authorizations. */
@property (strong, nonatomic, nonnull) id <SiriShortcutsAuthorizationManaging> siriShortcutsAuthorizationManager;

/** A SiriShortcutsAuthorizationManaging conforming object responsible for handling notifications authorizations. */
@property (strong, nonatomic, nonnull) id <NotificationsAuthorizationManaging> notificationsAuthorizationManager;

@end

@implementation SignInViewController

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self configure];
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

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)configure
{
    [self.signInButton setEnabled:NO];
    
    // Initialize the view controller's properties.
    self.rootNavigationHandler = [self.signInFactory makeRootNavigationHandler];
    self.userAuthenticationHandler = [self.signInFactory makeUserAuthenticationHandler];
    self.siriShortcutsAuthorizationManager = [self.signInFactory makeSiriShortcutsAuthorizationManager];
    self.notificationsAuthorizationManager = [self.signInFactory makeNotificationsAuthorizationManager];
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

- (void)onSuccessfulSignIn
{
    void (^siriAuthorizationCompletionHandler)(void) = ^{
        [self.rootNavigationHandler navigateToBottomNavigationViewController];
    };
    
    // The block of code to execute once we receive a response from the user for notifications
    // authorization.
    void (^notificationsAuthorizationCompletionHandler)(void) = ^{
        [self.siriShortcutsAuthorizationManager requestSiriAuthorization:siriAuthorizationCompletionHandler];
    };
    
    // Request the user's permission to display notifications.
    [self.notificationsAuthorizationManager requestNotificationsAuthorization:notificationsAuthorizationCompletionHandler];
}

- (void)onSignInFailureWithError:(NSError *)error;
{
    [self hideActivityIndicatorView];
    
    // Proceed with the appropriate flow given the error code .
    if (error.code == 404) {
        [self performSegueWithIdentifier:@"ShowSignUpProcessCompletionViewControllerSegue" sender:self];
    } /* The user's profile not found on database. */
    else {
        [self presentErrorAlertControllerWithMessage:error.localizedDescription];
    } /* Any other error. */
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
        if (error != NULL) {
            [weakSelf onSignInFailureWithError:error];
        } /* if NSError instance is not NULL */
        else {
            [weakSelf onSuccessfulSignIn];
        } /* if NSError instance is NULL */
    }];
}

- (IBAction)unwind:(UIStoryboardSegue *)segue
{
    [self onSuccessfulSignIn];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController * navigationController = (UINavigationController *) segue.destinationViewController;
    
    // Pass the appropriate dependencies to the appropriate View Controllers.
    if ([segue.identifier isEqualToString:@"ShowForgotPasswordViewControllerSegue"]) {
        ForgotPasswordViewController const * const forgotPasswordViewController = (ForgotPasswordViewController *) navigationController.visibleViewController;
        forgotPasswordViewController.userAuthenticationHandler = self.userAuthenticationHandler;
    } else if ([segue.identifier isEqualToString:@"ShowSignUpProcessCompletionViewControllerSegue"]) {
        SignUpProcessCompletionViewController const * const signUpProcessCompletionViewController = (SignUpProcessCompletionViewController *) navigationController.visibleViewController;
        signUpProcessCompletionViewController.emailAddress = self.emailAddressTextField.text;
        signUpProcessCompletionViewController.userAuthenticationHandler = self.userAuthenticationHandler;
        signUpProcessCompletionViewController.sessionUserFetchingHandler = [self.signInFactory makeSessionUserFetchingHandler];
    }
}

@end
