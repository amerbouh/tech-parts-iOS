//
//  SessionController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-14.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "SessionController.h"
#import <FirebaseAuth/FirebaseAuth.h>

@implementation SessionController {
    id <FIRUserDeleting> _userDeletionHandler;
}

#pragma mark - Initialization

- (instancetype)initWithUserDeletionHandler:(id<FIRUserDeleting>)userDeletionHandler
{
    self = [super init];
    if (self) {
        _userDeletionHandler = userDeletionHandler;
    }
    return self;
}

#pragma mark - Methods

- (NSString * _Nullable)getCurrentUserId
{
    FIRUser * const currentUser = [[FIRAuth auth] currentUser];
    
    // Returns the identifier of the currently signed-in user.
    return [currentUser uid];
}

- (void)signOutUser:(void (^)(NSError * _Nullable))completionHandler
{
    NSError * signOutError;
    FIRUser * currentUser = [[FIRAuth auth] currentUser];
    
    // Make sure that a user is currently logged-in.
    if (currentUser == NULL) {
        completionHandler(NULL);
        return;
    } /* There is no currenlty logged-in user. */
    
    // Attempt to sign out the user.
    [[FIRAuth auth] signOut:&signOutError];
    
    // Remove the user's profile from the device's local storage and call the completion
    // handler.
    [_userDeletionHandler deleteUserWithIdentifier:currentUser.uid completionHandler:^{
        completionHandler(signOutError);
    }];
}

@end
