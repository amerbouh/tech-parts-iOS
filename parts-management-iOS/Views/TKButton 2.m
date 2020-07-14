//
//  TKButton.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-30.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "TKButton.h"

@implementation TKButton

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configure];
    }
    return self;
}

#pragma mark - View's lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Configure the appearance of the button.
    [self configure];
}

#pragma mark - Methods

- (void)prepareForInterfaceBuilder
{
    [super prepareForInterfaceBuilder];
    
    // Configure the appearance of the button.
    [self setTitle:@"T4K Button" forState:UIControlStateNormal];
}

- (void)configure
{
    [self.layer setBorderWidth:self.borderWidth];
    [self.layer setBorderColor:self.borderColor.CGColor];
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
