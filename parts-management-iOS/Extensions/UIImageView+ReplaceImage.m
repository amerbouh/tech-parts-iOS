//
//  UIImageView+ReplaceImage.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-04-01.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "UIImageView+ReplaceImage.h"

@implementation UIImageView (ReplaceImage)

- (void)replaceWithImage:(UIImage *)newImage
{
    [UIView transitionWithView:self duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.image = newImage;
    } completion:NULL];
}

@end
