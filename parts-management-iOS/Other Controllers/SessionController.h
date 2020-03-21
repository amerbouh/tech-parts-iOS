//
//  SessionController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-14.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SessionManaging.h"
#import "FIRUserDeleting.h"

NS_ASSUME_NONNULL_BEGIN

@interface SessionController : NSObject <SessionManaging>

/**
 @brief Initializes and returns an instance  of the Session Controller with the provided parameters.

 @param userDeletionHandler A FIRUserDeleting conforming object used to delet e user profiles from the device's local storage
*/
- (instancetype)initWithUserDeletionHandler:(id <FIRUserDeleting>)userDeletionHandler;

@end

NS_ASSUME_NONNULL_END
