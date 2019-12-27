//
//  NSString+Empty.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-18.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "NSString+Empty.h"

@implementation NSString (NSString_Empty)

- (BOOL)isEmpty
{
    return [self isEqualToString:@""];
}

@end
