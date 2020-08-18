//
//  SettingsTableViewController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-03-14.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootNavigating.h"
#import "SessionEnding.h"
#import "FIRUserFetching.h"
#import "SessionUserFetching.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingsTableViewController : UITableViewController

@property (strong, nonatomic, nonnull) id <RootNavigating> rootNavigator;
@property (strong, nonatomic, nonnull) id <SessionEnding> sessionEndingHandler;
@property (strong, nonatomic, nonnull) id <FIRUserFetching> userFetchingHandler;
@property (strong, nonatomic, nonnull) id <SessionUserFetching> sessionUserFetchingHandler;

@end

NS_ASSUME_NONNULL_END
