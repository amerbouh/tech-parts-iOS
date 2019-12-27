//
//  FIRProjectFetching.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-21.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <FirebaseFirestore/FirebaseFirestore.h>

NS_ASSUME_NONNULL_BEGIN

@class Project;

@protocol FIRProjectFetching <NSObject>

/**
 @brief Attaches a listener to the Projects collection of the application's Cloud Firestore Database.
 
 @param completionHandler The completion handler to call when request completes.
 */
- (id<FIRListenerRegistration>)observeProjects:(void (^_Nullable)(NSArray<Project *> * _Nullable projects, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
