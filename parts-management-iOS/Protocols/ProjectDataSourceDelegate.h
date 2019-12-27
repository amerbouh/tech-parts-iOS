//
//  ProjectDataSourceDelegate.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ProjectDataSourceDelegate <NSObject>

- (BOOL)isFiltering;
- (void)onFetchCompleted;
- (void)onFetchFailedWithError:(NSError *)error;
- (void)onDeletionFailedWithError:(NSError *)error;
- (void)onDeleteProjectAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
