//
//  ImageCaching.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-04-04.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

NS_ASSUME_NONNULL_BEGIN

@protocol ImageCaching <NSObject>

/**
 @brief Removes the image corresponding to the given download URL from the cache.

 @param URL A URL instance representing the download URL of the image to remove
           from the cache.
*/
- (void)removeImageForURL:(NSURL * _Nonnull)URL;

/**
 @brief Fetches and returns the image corresponding to the given download URL from the cache.

 @param URL A URL instance representing the download URL of the image to fetch
           from the cache.
*/
- (UIImage * _Nullable)imageForURL:(NSURL * _Nonnull)URL;

/**
 @brief Adds the given UIImage instance to the cache using its download URL as an identifier.
 
 @param image A UIImage instance representing the image to cache.
 @param URL     A URL instance representing the download URL of the image to cache.
 */
- (void)addImage:(UIImage * _Nonnull)image forURL:(NSURL * _Nonnull)URL;

@end

NS_ASSUME_NONNULL_END
