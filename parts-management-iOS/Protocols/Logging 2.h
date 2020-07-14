//
//  Logging.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-06-12.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Logging <NSObject>

/** @brief Logs the given network-related information. */
- (void)logNetworkingInfo:(NSString * _Nonnull)info;

/** @brief Logs the given network-related error. */
- (void)logNetworkingError:(NSString * _Nonnull)error;

/** @brief Logs the given notifications-related error. */
- (void)logRemoteNotificationsError:(NSString * _Nonnull)error;

@end

NS_ASSUME_NONNULL_END
