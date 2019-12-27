//
//  JSONObjectPayload.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JSONObjectPayload <NSObject>

+ (instancetype)initWithJSON:(NSDictionary<NSString *, id> *)json;

@end

NS_ASSUME_NONNULL_END
