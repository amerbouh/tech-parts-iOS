//
//  ImageDownloadOperation.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-31.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "ImageDownloadOperation.h"

@interface ImageDownloadOperation ()

@property (strong, nonatomic, nonnull) NSURL * imageDownloadUrl;

@end

@implementation ImageDownloadOperation

#pragma mark - Initialization

- (instancetype)initWithImageDownloadUrl:(NSURL *)imageDownloadUrl
{
    self = [super init];
    if (self) {
        _imageDownloadUrl = [imageDownloadUrl copy];
    }
    return self;
}

#pragma mark - Methods

- (void)main
{
    if (self.isCancelled) return;
    
    // Fetch the image with the given download uRL.
    NSError * downloadError;
    NSData * const imageData = [NSData dataWithContentsOfURL:self.imageDownloadUrl options:0 error:&downloadError];
        
    // Check if the operation has been cancelled while fetching the image.
    if (self.isCancelled) return;

    // Make sure that no error occurred while trying to download the image.
    if (downloadError != NULL)
    {
        return;
    }
    
    // Initialize the downloaded image property.
    self.downloadedImage = [UIImage imageWithData:imageData];
}

@end
