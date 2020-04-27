//
//  AuthorizationManaging.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-04-04.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Operation.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AuthorizationManaging <NSObject>

/**
 @brief Resolves whether or not the user can perform the given operation.
 
 @param operation An operation enum case representing the operation the
                 authorization is resolved for.
 
 @return A boolean indicating whether or not the user can perform the given operation.
 */
- (BOOL)authorizeOperation:(Operation)operation;


@end

NS_ASSUME_NONNULL_END
