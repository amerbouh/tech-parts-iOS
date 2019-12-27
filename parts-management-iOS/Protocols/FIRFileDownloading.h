//
//  FIRFileDownloading.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-21.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FIRStorageDownloadTask;

@protocol FIRFileDownloading <NSObject>

- (FIRStorageDownloadTask *)downloadFileWithGCSURI:(NSString *)GCSURI fileName:(NSString *)fileName completionHandler:(void (^_Nullable)(NSURL * _Nullable localFileURL, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
