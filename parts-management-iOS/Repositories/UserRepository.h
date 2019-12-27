//
//  UserRepository.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FIRUserSaving.h"
#import "FIRUserFetching.h"

NS_ASSUME_NONNULL_BEGIN

@class User;

@interface UserRepository : NSObject <FIRUserSaving, FIRUserFetching>

@end

NS_ASSUME_NONNULL_END
