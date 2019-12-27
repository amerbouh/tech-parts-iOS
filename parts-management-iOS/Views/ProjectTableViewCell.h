//
//  ProjectTableViewCell.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-14.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Project;

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTableViewCell : UITableViewCell

/**
 @brief Populates the cell's views with the provided Project instance.
 
 @param project The Project instance used to populate the cell's views.
 */
- (void)populateWithProject:(Project *)project;

@end

NS_ASSUME_NONNULL_END
