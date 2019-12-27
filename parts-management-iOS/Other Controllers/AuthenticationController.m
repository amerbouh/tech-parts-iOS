//
//  AuthenticationController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "AuthenticationController.h"
#import "FirebaseAuth.h"
#import "UserRepository.h"
#import "FIRUserFetching.h"

@interface AuthenticationController ()

@property (strong, nonatomic, nonnull) id <FIRUserSaving> userSaver;
@property (strong, nonatomic, nonnull) id <FIRUserFetching> userFetcher;

@end

@implementation AuthenticationController

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        UserRepository * userRepository = [UserRepository new];
        
        // Initialize the instance variables.
        _userSaver = userRepository;
        _userFetcher = userRepository;
    }
    return self;
}

#pragma mark - Methods

- (void)signInUserWithEmailAddress:(NSString *)emailAddress password:(NSString *)password completionHandler:(void (^)(NSError * _Nullable))completionHandler
{
    __weak AuthenticationController * weakSelf = self;
    
    // Attempt to sign in the user with the given email address and password into his account.
    [[FIRAuth auth] signInWithEmail:emailAddress password:password completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(error);
            return;
        } /* if NSError instance is not NULL */
        
        // Fetch the User record on the database matching the logged in user uid.
        [weakSelf.userFetcher getUserWithIdentifier:authResult.user.uid completionHandler:^(User * _Nullable user, NSError * _Nullable error) {
            if (error != NULL) {
                completionHandler(error);
                return;
            } /* if NSError instance is not NULL */
            
            // Save the User record on the device's local storag and call the completion handler.
            [weakSelf.userSaver saveUser:user completionHandler:^{ completionHandler(NULL); }];
        }];        
    }];
}

@end
