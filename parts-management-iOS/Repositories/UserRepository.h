//
//  UserRepository.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FIRUserSaving.h"
#import "FIRUserDeleting.h"
#import "FIRUserFetching.h"

@class RLMRealm;
@class FIRFirestore;

NS_ASSUME_NONNULL_BEGIN

@interface UserRepository : NSObject <FIRUserSaving, FIRUserDeleting, FIRUserFetching>

/**
 @brief Initializes and returns an instance of the User Repository with the provided parameters.
 
 @param realm A RLMRealm instance representing the object used to read from the device's local storage.
 @param firestore A FIRFirestore instance representing the object used to interact with the application's database.
 */
- (instancetype)initWithRealm:(RLMRealm * _Nonnull)realm firestore:(FIRFirestore * _Nonnull)firestore;

@end

NS_ASSUME_NONNULL_END
