//
//  ImageCacheController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-04-04.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageCaching.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageCacheController : NSObject <ImageCaching>

+ (id<ImageCaching> _Nonnull)sharedImageCache;

@end

NS_ASSUME_NONNULL_END
