//
//  ProjectDetailViewController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-16.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthorizationManaging.h"

NS_ASSUME_NONNULL_BEGIN

@class Project;

@interface ProjectDetailViewController : UIViewController

/** A Project instance representing the project details displayed to the user by the View Controller . */
@property (strong, nonatomic, nonnull) Project * project;

/** An AuthorizationManaging conforming object reprensenting the object used to managed access control related matters. */
@property (strong, nonatomic, nonnull) id <AuthorizationManaging> authorizationManager;

@end

NS_ASSUME_NONNULL_END
