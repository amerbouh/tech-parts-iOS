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

- (instancetype)initWithIdentifier:(NSString *)identifier firstName:(NSString *)firstName lastName:(NSString *)lastName emailAddress:(NSString *)emailAddress timestamp:(NSDate *)timestamp
{
    self = [super init];
    if (self) {
        _id = identifier;
        _lastName = lastName;
        _timestamp = timestamp;
        _firstName = firstName;
        _emailAddress = emailAddress;
    }
    return self;
}

+ (instancetype)initWithJSON:(NSDictionary<NSString *,id> *)json
{
    NSString * identifier = (NSString *) json[@"id"];
    NSString * firstName = (NSString *) json[@"firstName"];
    NSString * lastName = (NSString *) json[@"lastName"];
    NSString * emailAddress = (NSString *) json[@"emailAddress"];
    FIRTimestamp * creationDate = (FIRTimestamp *) json[@"createdAt"];
    
    // Call the class's initializer.
    return [[User alloc] initWithIdentifier:identifier firstName:firstName lastName:lastName emailAddress:emailAddress timestamp:creationDate.dateValue];
}

@end
