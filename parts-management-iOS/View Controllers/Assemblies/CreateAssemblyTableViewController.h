//
//  CreateAssemblyTableViewController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-24.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Assembly;

@interface CreateAssemblyTableViewController : UITableViewController <UIPickerViewDelegate>

@property (strong, nonatomic, nullable) Assembly * assembly;
@property (strong, nonatomic, nonnull) NSString * projectIdentifier;

@end

NS_ASSUME_NONNULL_END
