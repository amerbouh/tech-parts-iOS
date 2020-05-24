//
//  FIRRegistrationTokenSaving.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-05-23.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FIRRegistrationTokenSaving <NSObject>

- (void)saveRegistrationToken:(NSString *)registrationToken forUserWithIdentifier:(NSString *)userIdentifier;

@end

NS_ASSUME_NONNULL_END
