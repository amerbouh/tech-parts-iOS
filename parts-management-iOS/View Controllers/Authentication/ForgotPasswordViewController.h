//
//  ForgotPasswordViewController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-28.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAuthenticating.h"

NS_ASSUME_NONNULL_BEGIN

@interface ForgotPasswordViewController : UIViewController

/** A UserAuthenticating conforming object responsible for authenticating users. */
@property (strong, nonatomic, nonnull) id <UserAuthenticating> userAuthenticationHandler;

@end

NS_ASSUME_NONNULL_END
