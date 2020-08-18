//
//  SessionUserFetching.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-08-04.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SessionUserFetching <NSObject>

/** @brief Returns the identifier of the currenlty signed-in user. */
- (NSString * _Nullable)getCurrentUserId;

@end

NS_ASSUME_NONNULL_END
