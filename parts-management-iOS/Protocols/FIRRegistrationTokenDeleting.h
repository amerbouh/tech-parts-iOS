//
//  FIRRegistrationTokenDeleting.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-05-24.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FIRRegistrationTokenDeleting <NSObject>

- (void)deleteRegistrationTokenForUserWithIdentifier:(NSString * _Nonnull)userIdentifier completionHandler:(void (^_Nullable)(NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
