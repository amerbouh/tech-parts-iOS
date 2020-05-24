//
//  ViewWorkInProgresIntentHandler.m
//  parts-management-intents
//
//  Created by Anas Merbouh on 2020-05-18.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "ViewWorkInProgresIntentHandler.h"

@implementation ViewWorkInProgresIntentHandler

- (void)handleViewWorkInProgress:(nonnull ViewWorkInProgressIntent *)intent completion:(nonnull void (^)(ViewWorkInProgressIntentResponse * _Nonnull))completion {
    NSUserActivity * const activity = [[NSUserActivity alloc] initWithActivityType:@"com.team3990.PartsManagement.viewWorkInProgress"];
    
    // Get an instance of the intent's response.
    ViewWorkInProgressIntentResponse * const viewWorkInProgressIntentResponse = [[ViewWorkInProgressIntentResponse alloc] initWithCode:ViewWorkInProgressIntentResponseCodeSuccess userActivity:activity];
    
    // Call the completion handler with the intent response.
    completion(viewWorkInProgressIntentResponse);
}

- (void)resolveProjectNameForViewWorkInProgress:(nonnull ViewWorkInProgressIntent *)intent withCompletion:(nonnull void (^)(INStringResolutionResult * _Nonnull))completion {
    return;
}

@end
