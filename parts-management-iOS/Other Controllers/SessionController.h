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

- (instancetype)initWithUserDeletionHandler:(id <FIRUserDeleting>)userDeletionHandler;

@end

NS_ASSUME_NONNULL_END
