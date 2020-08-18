//
//  SignUpProcessCompletionViewController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-07-01.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAuthenticating.h"
#import "SessionUserFetching.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignUpProcessCompletionViewController : UIViewController

/** A String representing the email address of the user completing the sign up process. */
@property (strong, nonatomic, nonnull) NSString * emailAddress;

/** A UserAuthenticating conforming object responsible for authenticating users. */
@property (strong, nonatomic, nonnull) id <UserAuthenticating> userAuthenticationHandler;

/** A SessionUserFetching conforming object responsible for fetching user sessions. */
@property (strong, nonatomic, nonnull) id <SessionUserFetching> sessionUserFetchingHandler;

@end

NS_ASSUME_NONNULL_END
