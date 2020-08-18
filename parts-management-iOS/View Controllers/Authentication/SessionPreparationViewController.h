//
//  SessionPreparationViewController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionEnding.h"
#import "RootNavigating.h"
#import "FIRUserFetching.h"

NS_ASSUME_NONNULL_BEGIN

@interface SessionPreparationViewController : UIViewController

/**
 A Root Navigating conforming object representing the object used to handle navigation accross
 the root screens of the application.
 */
@property (strong, nonatomic, nonnull) id <RootNavigating> rootNavigator;

/**
 A Session Managing conforming object representing the object used to end user sessions.
 */
@property (strong, nonatomic, nonnull) id <SessionEnding> sessionEndingHandler;

/** A FIRUerFetching conforming object representing the object used to fetch users. */
@property (strong, nonatomic, nonnull) id <FIRUserFetching> userFetchingHandler;

@end

NS_ASSUME_NONNULL_END
