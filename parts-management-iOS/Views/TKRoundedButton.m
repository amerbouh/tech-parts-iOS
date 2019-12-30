//
//  TKRoundedButton.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "TKRoundedButton.h"

@interface TKRoundedButton ()

- (void)configure;

@end

@implementation TKRoundedButton

#pragma mark - View's lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Configure the view.
    [self configure];
}

#pragma mark - Methods

- (void)prepareForInterfaceBuilder
{
    [super prepareForInterfaceBuilder];
    
    // Configure the view.
    [self configure];
}

- (void)configure
{
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:self.cornerRadius];
}

- (void)setEnabled:(BOOL)enabled
{
    if (enabled) {
        [self setAlpha:1.0];
    } /* if the button enters the enabled state */
    else {
        [self setAlpha:0.5];
    } /* if the button exits the enabled state  */
}

@end
