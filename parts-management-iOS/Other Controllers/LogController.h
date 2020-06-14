//
//  LogController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-06-12.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Logging.h"

NS_ASSUME_NONNULL_BEGIN

@interface LogController : NSObject <Logging>

+ (id<Logging>)sharedInstance;

@end

NS_ASSUME_NONNULL_END
