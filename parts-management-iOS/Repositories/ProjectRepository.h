//
//  ProjectRepository.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "FIRProjectFetching.h"
#import "FIRProjectCreating.h"
#import "FIRProjectDeleting.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectRepository : NSObject <FIRProjectFetching, FIRProjectCreating, FIRProjectDeleting>

@end

NS_ASSUME_NONNULL_END
