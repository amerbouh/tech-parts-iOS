//
//  RegistrationTokenRepository.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-05-23.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FIRRegistrationTokenSaving.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegistrationTokenRepository : NSObject <FIRRegistrationTokenSaving>

@end

NS_ASSUME_NONNULL_END
