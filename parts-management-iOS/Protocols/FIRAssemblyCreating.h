//
//  FIRAssemblyCreating.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-24.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Assembly;

@protocol FIRAssemblyCreating <NSObject>

/**
 @brief Uploads the given assembly to the Cloud Firestore database.
 
 @param assembly An assembly representing the data uploaded to Cloud Firestore.
 @param completionHandler The completion handler to call when request completes.
 */
- (void)createAssembly:(Assembly * _Nonnull)assembly completionHandler:(void (^_Nullable)(NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
