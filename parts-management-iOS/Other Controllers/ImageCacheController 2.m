//
//  ImageCacheController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-04-04.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "ImageCacheController.h"

@implementation ImageCacheController {
    NSCache<NSURL *, UIImage *> * _imageCache;
}

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        _imageCache = [NSCache new];
    }
    return self;
}

#pragma mark - Methods

- (void)removeImageForURL:(NSURL *)URL
{
    [_imageCache removeObjectForKey:URL];
}

- (UIImage *)imageForURL:(NSURL *)URL
{
    return [_imageCache objectForKey:URL];
}

- (void)addImage:(UIImage *)image forURL:(NSURL *)URL
{
    [_imageCache setObject:image forKey:URL];
}

#pragma mark - Helper Methods

+ (id<ImageCaching>)sharedImageCache
{
    static dispatch_once_t onceToken;
    static ImageCacheController * imageCacheController = nil;
    
    // Initialize the image cache controller, if applicable.
    dispatch_once(&onceToken, ^{
        imageCacheController = [ImageCacheController new];
    });
    
    return imageCacheController;
}

@end
