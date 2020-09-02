//
//  AssemblyListViewController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-22.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssemblyDataSourceDelegate.h"
#import "ProjectDetailViewControllerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AssemblyListViewController : UIViewController <UITableViewDelegate, UISearchBarDelegate, AssemblyDataSourceDelegate, ProjectDetailViewControllerDelegate>

/** A String representing the identifier of the project the currently viewed assemblies belong to. */
@property (strong, nonatomic, nonnull) NSString * projectIdentifier;

@end

NS_ASSUME_NONNULL_END
