//
//  FIRUserSaving.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class User;

@protocol FIRUserSaving <NSObject>

- (void)saveUser:(User *)user completionHandler:(void (^_Nullable)(void))completionHandler;

@end

NS_ASSUME_NONNULL_END
