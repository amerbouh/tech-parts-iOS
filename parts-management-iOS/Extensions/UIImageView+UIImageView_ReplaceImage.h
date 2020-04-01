//
//  UIImageView+UIImageView_ReplaceImage.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-04-01.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (UIImageView_ReplaceImage)

/**
 @brief Replaces the current image displayed by the image view by the given image with a cross dissolve animation.
 
 @param newImage A UIImage instance representing the new image that should be displayed by the image view.
 */
- (void)replaceWithImage:(UIImage * _Nonnull)newImage;

@end

NS_ASSUME_NONNULL_END
