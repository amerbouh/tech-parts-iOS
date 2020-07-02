//
//  SignUpProcessCompletionViewController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-07-01.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAuthenticating.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignUpProcessCompletionViewController : UIViewController

/** A UserAuthenticating conforming object responsible for authenticating users. */
@property (strong, nonatomic, nonnull) id <UserAuthenticating> userAuthenticationHandler;

@end

NS_ASSUME_NONNULL_END
