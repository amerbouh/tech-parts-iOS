//
//  SessionPreparationViewController.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootNavigating.h"
#import "FIRUserFetching.h"

NS_ASSUME_NONNULL_BEGIN

@interface SessionPreparationViewController : UIViewController

@property (strong, nonatomic, nonnull) id <RootNavigating> rootNavigator;
@property (strong, nonatomic, nonnull) id <FIRUserFetching> userFetchingHandler;

@end

NS_ASSUME_NONNULL_END
