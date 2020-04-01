//
//  AuthenticationController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "AuthenticationController.h"
#import "FirebaseAuth.h"

@implementation AuthenticationController {
    id <FIRUserSaving> _userSaver;
    id <FIRUserFetching> _userFetcher;
}

#pragma mark - Initialization

- (instancetype)initWithUserSavingHandler:(id<FIRUserSaving>)userSavingHandler userFetchingHandler:(id<FIRUserFetching>)userFetchingHandler
{
    self = [super init];
    if (self) {
        _userSaver = userSavingHandler;
        _userFetcher = userFetchingHandler;
    }
    return self;
}

#pragma mark - Methods

- (void)resetPasswordForUserWithEmailAddress:(NSString *)emailAddress completionHandler:(void (^)(NSError * _Nullable))completionHandler
{
    [[FIRAuth auth] sendPasswordResetWithEmail:emailAddress completion:completionHandler];
}

- (void)signInUserWithEmailAddress:(NSString *)emailAddress password:(NSString *)password completionHandler:(void (^)(NSError * _Nullable))completionHandler
{
    [[FIRAuth auth] signInWithEmail:emailAddress password:password completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(error);
            return;
        } /* if NSError instance is not NULL */
        
        // Fetch the User record on the database matching the logged in user uid.
        [self->_userFetcher getUserWithIdentifier:authResult.user.uid completionHandler:^(User * _Nullable user, NSError * _Nullable error) {
            if (error != NULL) {
                completionHandler(error);
                return;
            } /* if NSError instance is not NULL */
            
            // Save the User record on the device's local storage and call the completion handler.
            [self->_userSaver saveUser:user completionHandler:^{ completionHandler(NULL); }];
        }];        
    }];
}

@end
