//
//  CreateProjectTableViewController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FIRProjectCreating.h"

NS_ASSUME_NONNULL_BEGIN

@class Project;

@interface CreateProjectTableViewController : UITableViewController

/**
 @brief Sets the Project instance to edit in this View Controller.
 
 @param editedProject The Project instance whose information will be edited.
 */
- (void)setEditedProject:(Project *)editedProject;

@end

NS_ASSUME_NONNULL_END
