//
//  FIRAssemblyDeleting.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-25.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FIRAssemblyDeleting <NSObject>

/**
 @brief Deletes the assembly with the given identifier from the Cloud Firestore database.

 @param identifier An NSString representing the identifier of the record to delete from Cloud Firestore.
 @param completionHandler The completion handler to call when request completes.
*/
- (void)deleteAssemblyWithIdentifier:(NSString *)identifier completionHandler:(void (^_Nullable)(NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
