//
//  ProjectDetailViewControllerDelegate.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-24.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIBarButtonItem;
@class ProjectDetailViewController;

@protocol ProjectDetailViewControllerDelegate <NSObject>

- (void)projectDetailViewController:(ProjectDetailViewController *)projectDetailViewController didTapRightBarButtonItem:(UIBarButtonItem *)barButtonItem;

@end

NS_ASSUME_NONNULL_END
