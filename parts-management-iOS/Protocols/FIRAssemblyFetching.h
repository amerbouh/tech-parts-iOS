//
//  FIRAssemblyFetching.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-23.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <FirebaseFirestore/FirebaseFirestore.h>

NS_ASSUME_NONNULL_BEGIN

@class Assembly;

@protocol FIRAssemblyFetching <NSObject>

/**
 @brief Attaches a listener to the Assemblies collection of the application's Cloud Firestore Database.
 
 @param projectIdentifier A string representing the identifier of the project whose assemblies will
                         be fetched.
 @param completionHandler The completion handler to call when request completes.
 */
- (id<FIRListenerRegistration>)observeAssembliesForProjectWithIdentifier:(NSString *)projectIdentifier completionHandler:(void (^_Nullable)(NSArray<Assembly *> * _Nullable assemblies, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
