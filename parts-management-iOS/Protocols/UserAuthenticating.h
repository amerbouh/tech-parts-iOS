//
//  UserAuthenticating.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UserAuthenticating <NSObject>

/**
 @brief Sends an email to the given email address containing the instructions to reset a password.
 
 @param emailAddress An NSString representing the email address of the user the email needs to be sent to.
 @param completionHandler A block representing the executed block of code when the operation completes.
 */
- (void)resetPasswordForUserWithEmailAddress:(NSString *)emailAddress completionHandler:(void (^_Nullable)(NSError * _Nullable error))completionHandler;

/**
 @brief Signs the user with the given email address into his account.
 
 @param emailAddress An NSString representing the email address of the user.
 @param password An NSString representing the password of the user.
 @param completionHandler A block representing the executed block of code when the operation completes.
 */
- (void)signInUserWithEmailAddress:(NSString *)emailAddress password:(NSString *)password completionHandler:(void (^_Nullable)(NSError * _Nullable error))completionHandler;

/**
 @brief Completes the registration process of the user with the given identifier.
 
 @param uid  An NSString reprsesenting the unique identifier of the user.
 @param emailAddress An NSString representing the email address used by the user to sign up.
 @param firstName An NSString representing the first name of the user.
 @param lastName An NSString representing the last name of the user.
 */
- (void)completeSignUpProcessForUserWithId:(NSString * _Nonnull)uid emailAddress:(NSString * _Nonnull)emailAddress firstName:(NSString * _Nonnull)firstName lastName:(NSString * _Nonnull)lastName completionHandler:(void (^_Nullable)(NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
