//
//  TKRoundedButton.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "TKRoundedButton.h"

@implementation TKRoundedButton

#pragma mark - Methods

- (void)configure
{
    [super configure];
    
    // Set the button's corner radius.
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:self.cornerRadius];
}

@end
