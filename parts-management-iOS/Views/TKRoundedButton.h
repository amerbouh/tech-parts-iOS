//
//  TKRoundedButton.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "TKButton.h"

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface TKRoundedButton : TKButton

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

@end

NS_ASSUME_NONNULL_END
