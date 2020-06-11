//
//  TKButton.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-30.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface TKButton : UIButton

@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable UIColor * borderColor;

/** @brief Configures the appearance of the button. */
- (void)configure;

@end

NS_ASSUME_NONNULL_END
