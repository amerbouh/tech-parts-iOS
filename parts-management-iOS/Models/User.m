//
//  User.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "User.h"
#import "FirebaseFirestore.h"

@implementation User

#pragma mark - Initialization

- (instancetype)initWithIdentifier:(NSString *)identifier role:(UserRole)role firstName:(NSString *)firstName lastName:(NSString *)lastName emailAddress:(NSString *)emailAddress profileImageDownloadURL:(NSString *)profileImageDownloadURL timestamp:(NSDate *)timestamp
{
    self = [super init];
    if (self) {
        _role = role;
        _lastName = lastName;
        _firstName = firstName;
        _timestamp = timestamp;
        _identifier = identifier;
        _emailAddress = emailAddress;
        _profileImageDownloadURL = profileImageDownloadURL;
    }
    return self;
}

+ (instancetype)initWithJSON:(NSDictionary<NSString *,id> *)json
{
    NSString * role = (NSString *) json[@"role"];
    NSString * identifier = (NSString *) json[@"id"];
    NSString * firstName = (NSString *) json[@"firstName"];
    NSString * lastName = (NSString *) json[@"lastName"];
    NSString * emailAddress = (NSString *) json[@"emailAddress"];
    NSString * profileImageDownloadURL = (NSString *) json[@"profileImageDownloadUrl"];
    FIRTimestamp * creationDate = (FIRTimestamp *) json[@"createdAt"];
    
    // Call the class's initializer.
    return [[User alloc] initWithIdentifier:identifier role:user_role_from_string([role UTF8String]) firstName:firstName lastName:lastName emailAddress:emailAddress profileImageDownloadURL:profileImageDownloadURL timestamp:creationDate.dateValue];
}

#pragma mark - Methods

- (NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

+ (NSString *)primaryKey
{
    return @"identifier";
}

- (NSDictionary<NSString *,id> *)toDocumentData
{
    return @{
        @"id": self.identifier,
        @"lastName": self.lastName,
        @"firstName": self.firstName,
        @"emailAddress": self.emailAddress,
        @"profileImageDownloadUrl": self.profileImageDownloadURL,
        @"createdAt": [FIRTimestamp timestampWithDate:self.timestamp],
        @"role": [NSString stringWithCString:string_from_user_role(self.role) encoding:NSASCIIStringEncoding]
    };
}

@end
