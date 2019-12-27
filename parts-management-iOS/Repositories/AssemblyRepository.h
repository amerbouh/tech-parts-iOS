//
//  AssemblyRepository.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-23.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FIRAssemblyCreating.h"
#import "FIRAssemblyDeleting.h"
#import "FIRAssemblyFetching.h"

NS_ASSUME_NONNULL_BEGIN

@interface AssemblyRepository : NSObject <FIRAssemblyFetching, FIRAssemblyCreating, FIRAssemblyDeleting>

@end

NS_ASSUME_NONNULL_END
