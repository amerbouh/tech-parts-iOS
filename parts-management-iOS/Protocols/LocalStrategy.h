//
//  LocalStrategy.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-07-04.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LocalStrategy <NSObject>

/**
 @brief Saves the given entity in the device's persistent store.
 
 @param entitiy Any object representing the entity to save.
 */
- (void)save:(id)entity;

/**
 @brief Returns the entity with the given identifier from the device's persistent store.
 
 @param A String representing the unique identifier of th entity to fetch.
 */
- (id)getById:(NSString * _Nonnull)identifier;

/**
 @brief Deletes the entity with the given identifier from the device's persistent store.
 
 @param A String representing the unique identifier of the entity to delete.
 */
- (void)deleteById:(NSString * _Nonnull)identifier;

@end

NS_ASSUME_NONNULL_END
