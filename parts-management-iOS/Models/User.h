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

NS_ASSUME_NONNULL_BEGIN

@interface User : RLMObject <JSONObjectPayload>

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

- (instancetype)initWithIdentifier:(NSString * _Nonnull)identifier role:(UserRole)role firstName:(NSString * _Nonnull)firstName lastName:(NSString * _Nonnull)lastName emailAddress:(NSString * _Nonnull)emailAddress profileImageDownloadURL:(NSString * _Nonnull)profileImageDownloadURL timestamp:(NSDate * _Nonnull)timestamp;

@end

NS_ASSUME_NONNULL_END
