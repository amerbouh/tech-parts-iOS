//
//  SessionController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-14.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "SessionController.h"
#import <FirebaseAuth/FirebaseAuth.h>

@interface SessionController ()

@property (strong, nonatomic, nonnull) id <FIRUserDeleting> userDeletionHandler;
@property (strong, nonatomic, nonnull) id <FIRRegistrationTokenDeleting> registrationTokenDeletionHandler;

@end

@implementation SessionController

#pragma mark - Initialization

- (instancetype)initWithUserDeletionHandler:(id<FIRUserDeleting>)userDeletionHandler registrationTokenDeletionHandler:(id<FIRRegistrationTokenDeleting>)registrationTokenDeletionHandler
{
    self = [super init];
    if (self) {
        _userDeletionHandler = userDeletionHandler;
        _registrationTokenDeletionHandler = registrationTokenDeletionHandler;
    }
    return self;
}

#pragma mark - Methods

- (NSString * _Nullable)getCurrentUserId
{
    FIRUser * currentUser = [[FIRAuth auth] currentUser];
    
    // Returns the identifier of the currently signed-in user.
    return [currentUser uid];
}

- (void)signOutUser:(void (^)(NSError * _Nullable))completionHandler
{
    FIRUser * currentUser = [[FIRAuth auth] currentUser];
    
    // Make sure that a user is currently logged-in.
    if (currentUser == NULL) {
        completionHandler(NULL);
        return;
    } /* There is no currenlty logged-in user. */
    
    // Obtain a weak reference to the controller object.
    __weak SessionController const * const weakSelf = self;
    
    // Remove the user's registration token from the Realtime Database.
    [self.registrationTokenDeletionHandler deleteRegistrationTokenForUserWithIdentifier:currentUser.uid completionHandler:^(NSError * _Nullable error) {
        if (error) {
            completionHandler(error);
            return;
        } /* An error occurred while trying to delete the token. */
        
        // Attempt to sign out the user.
        NSError * signOutError;
        [[FIRAuth auth] signOut:&signOutError];
        
        // Check if an error occurred while trying to sign out the user.
        if (signOutError) {
            completionHandler(signOutError);
        } /* An error occurred while trying to sign out the user. */
    
        // Remove the user's profile from the device's local storage.
        [weakSelf.userDeletionHandler deleteUserWithIdentifier:currentUser.uid];
        
        // Call the completion handler.
        completionHandler(NULL);
    }];
}

@end
