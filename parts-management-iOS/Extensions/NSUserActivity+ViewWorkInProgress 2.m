//
//  NSUserActivity+ViewWorkInProgress.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-05-18.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "NSUserActivity+ViewWorkInProgress.h"

@implementation NSUserActivity (ViewWorkInProgress)

#pragma mark - Methods

+ (NSString *)stringFromUserActivityKey:(NSUserActivityKey)key
{
    switch (key) {
        case NSUserActivityKeyProjectID:
            return @"projectID";
            
        default:
            return NULL;
    }
}

@end
