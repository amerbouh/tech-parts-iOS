//
//  AuthorizationController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-04-04.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthorizationManaging.h"

NS_ASSUME_NONNULL_BEGIN

@class User;

@interface AuthorizationController : NSObject <AuthorizationManaging>

- (instancetype)initWithUser:(User * _Nonnull)user;

@end

NS_ASSUME_NONNULL_END
