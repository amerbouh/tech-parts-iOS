//
//  FIRUserSaving.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class User;

@protocol FIRUserSaving <NSObject>

/**
 @brief Save the given user on the device's local storage.
 
 @param user A User representing the data saved on the device's local storage..
 @param completionHandler The completion handler to call when request completes.
 */
- (void)saveUser:(User *)user completionHandler:(void (^_Nullable)(void))completionHandler;

/**
 @brief Save the given information on the application's Cloud Firestore database for the user wtih
        the given identifier.

 @param user A User representing the object used to create a profile on the Cloud Firestore database.
 @param completionHandler The completion handler to call when request completes.
*/
- (void)createProfileForUser:(User * _Nonnull)user completionHandler:(void (^_Nullable)(NSError * _Nullable error))completionHandler;;

@end

NS_ASSUME_NONNULL_END
