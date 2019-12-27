//
//  FileSize.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-21.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "FileSize.h"

@implementation FileSize

#pragma mark - Initialization

- (instancetype)initWithValue:(NSNumber *)value unit:(NSString *)unit
{
    self = [super init];
    if (self) {
        _unit = unit;
        _value = value;
    }
    return self;
}

+ (instancetype)initWithJSON:(NSDictionary<NSString *,id> *)json
{
    NSString * unit = (NSString *) json[@"unit"];
    NSNumber * value = (NSNumber *) json[@"value"];
    
    return [[FileSize alloc] initWithValue:value unit:unit];
}

@end
