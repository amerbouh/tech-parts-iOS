//
//  AssemblyTableViewCell.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-22.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Assembly;

@interface AssemblyTableViewCell : UITableViewCell

/**
 @brief Populates the cell's views with the provided Assembly instance.
 
 @param assembly The Assembly instance used to populate the cell's views.
 */
- (void)populateWithAssembly:(Assembly *)assembly;

@end

NS_ASSUME_NONNULL_END
