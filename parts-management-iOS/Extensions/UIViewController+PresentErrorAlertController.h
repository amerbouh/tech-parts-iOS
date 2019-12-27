//
//  UIViewController+PresentErrorAlertController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-21.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (PresentErrorAlertController)

/**
 @brief Displays an UIAlertController with the given message.
 
 @param message A string representing the message to display with the presented UIAlertController instance.
 */
- (void)presentErrorAlertControllerWithMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
