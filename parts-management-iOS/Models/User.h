//
//  User.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Realm.h"
#import "JSONObjectPayload.h"

NS_ASSUME_NONNULL_BEGIN

@interface User : RLMObject <JSONObjectPayload>

/** A string representing the identifier of the user. */
@property (strong, nonatomic, nonnull) NSString * id;

/** A string representing the first name of the user. */
@property (strong, nonatomic, nonnull) NSString * firstName;

/** A string representing the last name of the user. */
@property (strong, nonatomic, nonnull) NSString * lastName;

/** A string representing the email address of the user. */
@property (strong, nonatomic, nonnull) NSString * emailAddress;

/** A date object representing creation date of the user.  */
@property (strong, nonatomic, nonnull) NSDate * timestamp;

- (instancetype)initWithIdentifier:(NSString *)identifier firstName:(NSString *)firstName lastName:(NSString *)lastName emailAddress:(NSString *)emailAddress timestamp:(NSDate *)timestamp;

@end

NS_ASSUME_NONNULL_END
