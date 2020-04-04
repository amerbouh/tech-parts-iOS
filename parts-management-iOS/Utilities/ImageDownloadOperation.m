//
//  ImageDownloadOperation.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-31.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "ImageDownloadOperation.h"

struct RandomNumberGenerator
{
    int min, max;
    
    
    
};

@implementation ImageDownloadOperation {
    NSURL * _imageDownloadUrl;
    NSCache<NSURL *, UIImage *> * _cache;
}

#pragma mark - Initialization

- (instancetype)initWithImageDownloadUrl:(NSURL *)imageDownloadUrl
{
    self = [super init];
    if (self) {
        _cache = [NSCache new];
        _imageDownloadUrl = [imageDownloadUrl copy];
    }
    return self;
}

#pragma mark - Methods

- (void)main
{
    if (self.isCancelled) return;
    
    // Check if the image is present on the cache.
    self.downloadedImage = [_cache objectForKey:_imageDownloadUrl];
    
    // If the image was found on the cache, stop the execution of
    // the method.
    if (self.downloadedImage != NULL) return;
    
    // Fetch the image with the given download uRL.
    NSError * downloadError;
    NSData * const imageData = [NSData dataWithContentsOfURL:_imageDownloadUrl options:0 error:&downloadError];
        
    // Check if the operation has been cancelled while fetching the image.
    if (self.isCancelled) return;

    // Make sure that no error occurred while trying to download the image.
    if (downloadError != NULL) return;
        
    // Add the downloaded image to the cache.
    UIImage * const downloadedImage = [UIImage imageWithData:imageData];
    [_cache setObject:downloadedImage forKey:_imageDownloadUrl];
    
    // Check if the operation has been cancelled while caching the image.
    if (self.isCancelled) return;
    
    // Initialize the downloaded image property.
    self.downloadedImage = downloadedImage;
}

@end
