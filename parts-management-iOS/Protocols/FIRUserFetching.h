//
//  FIRUserFetching.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class User;

@protocol FIRUserFetching <NSObject>

/**
 @brief Fetches the User record matching the given user identifier on the application's Cloud Firestore Database.
 
 @param uid A string representing the identifier of the User instance to fetch.
 @param completionHandler The completion handler to call when request completes.
 */
- (void)getUserWithIdentifier:(NSString *)uid completionHandler:(void (^_Nullable)(User * _Nullable user, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
