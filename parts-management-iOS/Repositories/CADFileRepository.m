//
//  CADFileRepository.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-21.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "CADFileRepository.h"
#import <FirebaseStorage/FirebaseStorage.h>

@implementation CADFileRepository {
    FIRStorage * _storage;
}

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        _storage = [FIRStorage storage];
    }
    return self;
}

#pragma mark - Methods

- (FIRStorageDownloadTask *)downloadFileWithGCSURI:(NSString *)GCSURI fileName:(NSString *)fileName completionHandler:(void (^)(NSURL * _Nullable, NSError * _Nullable))completionHandler
{
    FIRStorageReference * fileReference = [_storage referenceForURL:GCSURI];

    // Get an instance of the File Manager.
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    // Get an instance of the application's Documents directory.
    NSURL * documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    // Get an instance of the file's directory.
    NSURL * fileDirectory = [documentsDirectory URLByAppendingPathComponent:fileName];
    
    // Download the CAD File to the local filesystem.
    return [fileReference writeToFile:fileDirectory completion:completionHandler];
}

@end
