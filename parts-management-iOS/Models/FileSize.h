//
//  FileSize.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-21.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONObjectPayload.h"

NS_ASSUME_NONNULL_BEGIN

@interface FileSize : NSObject <JSONObjectPayload>

@property (strong, nonnull, nonatomic) NSString * unit;
@property (strong, nonnull, nonatomic) NSNumber * value;

- (instancetype)initWithValue:(NSNumber * _Nonnull)value unit:(NSString * _Nonnull)unit;

@end

NS_ASSUME_NONNULL_END
