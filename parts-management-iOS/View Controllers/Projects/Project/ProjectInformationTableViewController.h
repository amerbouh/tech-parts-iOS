//
//  ProjectInformationTableViewController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Project;

@interface ProjectInformationTableViewController : UITableViewController

@property (strong, nonatomic, nonnull) Project * project;

@end

NS_ASSUME_NONNULL_END
