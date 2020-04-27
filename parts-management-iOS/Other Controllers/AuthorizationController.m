//
//  AuthorizationController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-04-04.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "AuthorizationController.h"
#import "User.h"
#import "UserRole.h"

@implementation AuthorizationController {
    User * _user;
}

#pragma mark - Initialization

- (instancetype)initWithUser:(User *)user
{
    self = [super init];
    if (self) {
        _user = user;
    }
    return self;
}

#pragma mark - Methods

- (BOOL)authorizeOperation:(Operation)operation
{
    BOOL isOperationAuthorized = NO;
    
    // Resolve whether or not the user is allowed to perform the given
    // operation.
    switch (operation) {
        case CREATE_PROJECT:
            isOperationAuthorized = _user.role == MENTOR;
            break;
            
        case DELETE_PROJECT:
            isOperationAuthorized = _user.role == MENTOR;
            break;
            
        default:
            break;
    }
    
    return isOperationAuthorized;
}

@end
