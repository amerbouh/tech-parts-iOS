//
//  ImageDownloadOperation.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-31.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageDownloadOperation : NSOperation

@property (strong, nonatomic, nonnull) UIImage * downloadedImage;

/**
 @brief Initializes and returns an instance of the Image Download Operation with the provided parameters.
 
 @param imageDownloadUrl A NSURL instance representing the download URL of the image that needs to
        be downloaded
 */
- (instancetype)initWithImageDownloadUrl:(NSURL * _Nonnull)imageDownloadUrl;

@end

NS_ASSUME_NONNULL_END
