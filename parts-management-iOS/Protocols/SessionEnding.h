//
//  SessionEnding.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-08-04.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SessionEnding <NSObject>

/**
 @brief Signs out the currenlty authenticated user and removes his data from the device's local storage.
 
 @param completionHandler The completion handler to call when the operation completes.
 */
- (void)signOutUser:(void (^_Nullable)(NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
