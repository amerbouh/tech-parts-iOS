//
//  ProjectListViewController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthorizationManaging.h"
#import "ProjectDataSourceDelegate.h"

@interface ProjectListViewController : UIViewController <UITableViewDelegate, UISearchResultsUpdating, ProjectDataSourceDelegate>

@property (strong, nonatomic, nonnull) id <AuthorizationManaging> authorizationManager;

@end

