//
//  LogController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-06-12.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "LogController.h"
#import <OS/log.h>

@implementation LogController {
    os_log_t _networkingLogType;
    os_log_t _remoteNotificationsLogType;
}

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        _networkingLogType = os_log_create("com.team3990.tech_parts", "networking");
        _remoteNotificationsLogType = os_log_create("com.team3990.tech_parts", "remote_notifications");
    }
    return self;
}

#pragma mark - Methods

- (void)logNetworkingInfo:(NSString *)info
{
    os_log_info(_networkingLogType, "%@", info);
}

- (void)logNetworkingError:(NSString *)error
{
    os_log_error(_networkingLogType, "%@", error);
}

- (void)logRemoteNotificationsError:(NSString *)error
{
    os_log_error(_remoteNotificationsLogType, "%@", error);
}

#pragma mark - Helper methods

+ (id<Logging>)sharedInstance {
    static dispatch_once_t onceToken;
    static LogController * logController = nil;
    
    // Initialize the image cache controller, if applicable.
    dispatch_once(&onceToken, ^{
        logController = [LogController new];
    });
    
    return logController;
}

@end
