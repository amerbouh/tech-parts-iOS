//
//  MessageView.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-17.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageView : UIView

/**
 @brief Sets the text displayed by the view's title label.

 @param title The text that should be displayed by the title label.
*/
- (void)setTitle:(NSString *)title;

/**
 @brief Sets the text displayed by the view's message label.

 @param message The text that should be displayed by the message label.
*/
- (void)setMessage:(NSString *)message;

/**
 @brief Initializes and returns a new Message View instance using the provided parameters.

 @param title The text that should be displayed by the title label.
 @param message The text that should be displayed by the message label.
 @param frame The frame of the view.
*/
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
