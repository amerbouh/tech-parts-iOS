//
//  FIRProjectCreating.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Project;

@protocol FIRProjectCreating <NSObject>

/**
 @brief Uploads the given project to the application's Cloud Firestore database.
 
 @param project A Project representing the data uploaded to Cloud Firestore.
 @param completionHandler The completion handler to call when request completes.
 */
- (void)createProject:(Project * _Nonnull)project completionHandler:(void (^_Nullable)(NSError * _Nullable error))completionHandler;

/**
@brief Updates the given project on the Cloud Firestore database.

@param project A Project representing the updated data uploaded to Cloud Firestore.
@param completionHandler The completion handler to call when request completes.
*/
- (void)updateProject:(Project *)project completionHandler:(void (^_Nullable)(NSError * _Nullable error))completionHandler;


@end

NS_ASSUME_NONNULL_END
