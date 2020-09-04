//
//  SignInViewController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignInFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignInViewController : UIViewController

@property (strong, nonatomic, nonnull) id <SignInFactory> signInFactory;

@end

NS_ASSUME_NONNULL_END
