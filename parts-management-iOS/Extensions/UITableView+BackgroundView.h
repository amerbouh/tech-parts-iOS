//
//  UITableView+BackgroundView.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (BackgroundView)

- (void)removeBackgroundView;
- (void)displayErrorViewWithMessage:(NSString *)message;
- (void)displayMessage:(NSString *)message withTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
