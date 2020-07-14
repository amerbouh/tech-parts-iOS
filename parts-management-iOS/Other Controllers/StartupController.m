//
//  StartupController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-05-27.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "StartupController.h"
#import <Firebase/Firebase.h>

@interface StartupController ()

/** @brief Resolves the path of the Firebase Configuration File. */
+ (NSString * _Nonnull)resolveFirebaseConfigurationFilePath;

@end

@implementation StartupController {
    UIApplication * _application;
    id <UIApplicationDelegate> _appDelegate;
}

#pragma mark - Initialization

- (instancetype)initWithApp:(UIApplication *)application appDelegate:(id<UIApplicationDelegate>)appDelegate
{
    self = [super init];
    if (self) {
        _application = application;
        _appDelegate = appDelegate;
    }
    return self;
}

#pragma mark - Methods

- (void)runStartupSequence
{
    NSString * firebaseConfigurationFile = [StartupController resolveFirebaseConfigurationFilePath];
    FIROptions * firebaseOptions = [[FIROptions alloc] initWithContentsOfFile:firebaseConfigurationFile];
    
    // Configure Firebase with the appropriate optiosn.
    [FIRApp configureWithOptions:firebaseOptions];
    
    // Assign the FIRMessaging's delegate, if applicable.
    if ([_appDelegate conformsToProtocol:@protocol(FIRMessagingDelegate)]) {
        [FIRMessaging.messaging setDelegate:(id <FIRMessagingDelegate>) _appDelegate];
    }
    
    // Attempt to register for remote notifications.
    [_application registerForRemoteNotifications];
}

+ (NSString *)resolveFirebaseConfigurationFilePath
{
    NSBundle const * const mainBundle = [NSBundle mainBundle];
    NSString * firebaseConfigurationFileName = (NSString *) [mainBundle objectForInfoDictionaryKey:@"Firebase Configuration File Name"];
    
    // Return the path for the Firebase Configuration File.
    return [mainBundle pathForResource:firebaseConfigurationFileName ofType:@"plist"];
}

@end
