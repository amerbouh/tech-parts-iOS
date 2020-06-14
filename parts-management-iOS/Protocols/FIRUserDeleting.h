//
//  FIRUserDeleting.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-14.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FIRUserDeleting <NSObject>

- (void)deleteUserWithIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
