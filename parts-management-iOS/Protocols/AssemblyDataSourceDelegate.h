//
//  AssemblyDataSourceDelegate.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-23.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AssemblyDataSourceDelegate <NSObject>

- (BOOL)isFiltering;
- (void)onFetchCompleted;
- (void)onFetchFailedWithError:(NSError *)error;
- (void)onDeletionFailedWithError:(NSError *)error;
- (void)onDeleteAssemblyAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
