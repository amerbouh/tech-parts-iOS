//
//  User.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Realm.h"
#import "UserRole.h"
#import "JSONObjectPayload.h"
#import "FIRDocumentSerializable.h"

NS_ASSUME_NONNULL_BEGIN

@interface User : RLMObject <JSONObjectPayload, FIRDocumentSerializable>

/** A User role enum case representing the role of the user. */
@property (assign, nonatomic) UserRole role;

/** A string representing the identifier of the user. */
@property (strong, nonatomic, nonnull) NSString * identifier;

/** A string representing the first name of the user. */
@property (strong, nonatomic, nonnull) NSString * firstName;

/** A string representing the last name of the user. */
@property (strong, nonatomic, nonnull) NSString * lastName;

/** A string representing the email address of the user. */
@property (strong, nonatomic, nonnull) NSString * emailAddress;

/** A string representing the download URL of the user's profile image. */
@property (strong, nonatomic, nonnull) NSString * profileImageDownloadURL;

/** A date object representing creation date of the user.  */
@property (strong, nonatomic, nonnull) NSDate * timestamp;

/** A date object representing creation date of the user.  */
@property (strong, nonatomic, nonnull, readonly) NSString * fullName;

/**
 @brief Initializes a new User instance with the provided parameters.
 
 @param identifier A String representing the unique identifier of the user.
 @param role A UserRole enum case representing the role of the user.
 @param firstName A String representing the first name of the user.
 @param lastName A String representing the last name of the user.
 @param emailAddress A String representing the email address of the user.
 @param profileImageDownloadURL A String representing the download URL of the profile image
                               of the user.
 @param timestamp A Date representing the creation date of the user.
 */
- (instancetype)initWithIdentifier:(NSString * _Nonnull)identifier role:(UserRole)role firstName:(NSString * _Nonnull)firstName lastName:(NSString * _Nonnull)lastName emailAddress:(NSString * _Nonnull)emailAddress profileImageDownloadURL:(NSString * _Nonnull)profileImageDownloadURL timestamp:(NSDate * _Nonnull)timestamp;

@end

NS_ASSUME_NONNULL_END
