//
//  TKRoundedView.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "TKRoundedView.h"

@interface TKRoundedView ()

/** @brief Configures the appearance of the view. */
- (void)configure;

@end

@implementation TKRoundedView

#pragma mark - View's lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Configure the view.
    [self configure];
}

#pragma mark - Methods

- (void)configure
{
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:self.cornerRadius];
}

@end
