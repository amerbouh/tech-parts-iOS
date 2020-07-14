//
//  RemoteStrategy.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-07-04.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RemoteStrategy <NSObject>

/**
 @brief Saves the given entity in the device's persistent store.
 
 @param entitiy Any object representing the entity to save.
 @param completionHandler The completion handler to call when operation completes.
 */
- (void)save:(id)entity completionHandler:(void (^_Nullable)(void))completionHandler;

/**
 @brief Returns the entity with the given identifier from the device's persistent store.
 
 @param A String representing the unique identifier of th entity to fetch.
 @param completionHandler The completion handler to call when operation completes.
 */
- (void)getById:(NSString * _Nonnull)identifier completionHandler:(void (^_Nullable)(void))completionHandler;

/**
 @brief Deletes the entity with the given identifier from the device's persistent store.
 
 @param A String representing the unique identifier of the entity to delete.
 @param completionHandler The completion handler to call when operation completes.
 */
- (void)deleteById:(NSString * _Nonnull)identifier completionHandler:(void (^_Nullable)(void))completionHandler;

@end

NS_ASSUME_NONNULL_END
