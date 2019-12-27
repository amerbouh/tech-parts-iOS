//
//  ProjectDetailViewController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-16.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Project;

@interface ProjectDetailViewController : UIViewController

/** A Project instance representing the project details displayed to the user by the View Controller . */
@property (strong, nonatomic, nonnull) Project * project;

@end

NS_ASSUME_NONNULL_END
