//
//  SiriShortcutsAuthorizationManaging.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-05-23.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SiriShortcutsAuthorizationManaging <NSObject>

/**
 @brief Requests the user's authorization to use Siri services.

 @param completionHandler A block representng the code to execute when the authorization status for the application
                        is determined.
*/
- (void)requestSiriAuthorization:(void (^_Nullable)(void))completionHandler;

@end

NS_ASSUME_NONNULL_END
