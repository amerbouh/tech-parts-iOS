//
//  SignInViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "SignInViewController.h"
#import "UserAuthenticating.h"
#import "AuthenticationController.h"
#import "NSString+Empty.h"
#import "UIViewController+PresentErrorAlertController.h"

@interface SignInViewController ()

@property (weak, nonatomic) IBOutlet UILabel * loginPromptLabel;

@property (weak, nonatomic) IBOutlet UITextField * emailAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField * passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton * signInButton;
@property (weak, nonatomic) IBOutlet UIButton * forgotPasswordButton;

/** A UserAuthenticating conforming object responsible for authenticating users. */
@property (strong, nonatomic, nonnull) id <UserAuthenticating> userAuthenticator;

/** @brief Updates the layout of the view managed by the View Controller in order to accomodate the lack of a keyboard.  */
- (void)keyboardWillHide;

/** @brief Updates the layout of the view managed by the View Controller in order to accomodate a keyboard.  */
- (void)keyboardWillShow;

/** @brief Updates the state of the sign in button according to the inputs of the form. */
- (void)formInputsDidChangeValue;

/** @brief Enables user interaction on the sign in button.  */
- (void)enableSignInButton;

/** @brief Disables user interaction on the sign in button.  */
- (void)disableSignInButton;

/** @brief Configures the translations of the text displayed by the View Controller. */
- (void)configureLocalizations;

/** @brief Navigates the user to the Bottom Navigation View Controller. */
- (void)navigateToBottomNavigationViewController;

@end

@implementation SignInViewController

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _userAuthenticator = [AuthenticationController new];
    }
    return self;
}

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self disableSignInButton];
    [self configureLocalizations];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Do any additional setup before the view appears.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:NULL];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:NULL];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(formInputsDidChangeValue) name:UITextFieldTextDidChangeNotification object:NULL];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Do any additional setup before the view disappears.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Methods

- (void)keyboardWillHide
{
    NSLog(@"The keyboard is about to be hidden ...");
}

- (void)keyboardWillShow
{
    NSLog(@"The keyboard is about to be shown ...");
}

- (void)formInputsDidChangeValue
{
    if ([self.emailAddressTextField.text isEmpty] || [self.passwordTextField.text isEmpty]) {
        [self disableSignInButton];
    } /* if form contains empty text field */
    else {
        [self enableSignInButton];
    } /* if form does not contain empty text field */
}

- (void)enableSignInButton
{
    [self.signInButton setAlpha:1];
    [self.signInButton setEnabled:YES];
}

- (void)disableSignInButton
{
    [self.signInButton setAlpha:0.5];
    [self.signInButton setEnabled:NO];
}

- (void)configureLocalizations
{
    [self.loginPromptLabel setText:NSLocalizedString(@"loginPrompt", NULL)];
    [self.passwordTextField setPlaceholder:NSLocalizedString(@"password", NULL)];
    [self.emailAddressTextField setPlaceholder:NSLocalizedString(@"emailAddress", NULL)];
    [self.signInButton setTitle:NSLocalizedString(@"signIn", NULL) forState:UIControlStateNormal];
    [self.forgotPasswordButton setTitle:NSLocalizedString(@"forgotPassword", NULL) forState:UIControlStateNormal];
}

- (void)navigateToBottomNavigationViewController
{
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (IBAction)signInButtonTaped:(UIButton *)sender
{
    [self disableSignInButton];
    
    // Create a weak reference to the View Controller to avoid strong reference cycles.
    __weak SignInViewController * weakSelf = self;
    
    // Attempt to authenticate the user.
    [self.userAuthenticator signInUserWithEmailAddress:self.emailAddressTextField.text password:self.passwordTextField.text completionHandler:^(NSError * _Nullable error) {
        [weakSelf enableSignInButton];
        
        if (error != NULL) {
            [weakSelf presentErrorAlertControllerWithMessage:error.localizedDescription];
            return;
        } /* if NSError instance is not NULL */
        
        [weakSelf navigateToBottomNavigationViewController];
    }];
}

@end
