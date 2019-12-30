//
//  UserAuthenticating.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UserAuthenticating <NSObject>

- (void)resetPasswordForUserWithEmailAddress:(NSString *)emailAddress completionHandler:(void (^_Nullable)(NSError * _Nullable error))completionHandler;
- (void)signInUserWithEmailAddress:(NSString *)emailAddress password:(NSString *)password completionHandler:(void (^_Nullable)(NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
