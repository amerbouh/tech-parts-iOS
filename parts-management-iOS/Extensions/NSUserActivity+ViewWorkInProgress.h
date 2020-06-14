//
//  NSUserActivity+ViewWorkInProgress.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-05-18.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** An enumeration representing all the valid keys to access app state restoration related data. */
typedef NS_ENUM(NSInteger, NSUserActivityKey) {
    NSUserActivityKeyProjectID
};

@interface NSUserActivity (ViewWorkInProgress)

/**
 @brief Returns a string representation of the given user activity key.
 
 @param key A NSUserActivityKey enum case representing the key for which the string representation will be generated.
 */
+ (NSString * _Nullable)stringFromUserActivityKey:(NSUserActivityKey)key;

@end

NS_ASSUME_NONNULL_END
