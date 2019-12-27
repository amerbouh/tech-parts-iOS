//
//  AssemblyInformationTableViewController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-25.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Assembly;

@interface AssemblyInformationTableViewController : UITableViewController

@property (strong, nonatomic, nonnull) Assembly * assembly;

@end

NS_ASSUME_NONNULL_END
