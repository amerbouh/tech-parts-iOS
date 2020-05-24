//
//  SiriShorcutsController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-05-23.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "SiriShorcutsController.h"
#import <Intents/Intents.h>

@implementation SiriShorcutsController

#pragma mark - Methods

- (void)requestSiriAuthorization:(void (^)(void))completionHandler
{
    [INPreferences requestSiriAuthorization:^(INSiriAuthorizationStatus status) {
        if (completionHandler != NULL) {
            completionHandler();
        } /* Call the completion handler if it's not NULL. */
    }];
}

@end
