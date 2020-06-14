//
//  IntentHandler.m
//  parts-management-intents
//
//  Created by Anas Merbouh on 2020-05-18.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "IntentHandler.h"
#import "ViewWorkInProgresIntentHandler.h"

@interface IntentHandler ()

@end

@implementation IntentHandler

- (id)handlerForIntent:(INIntent *)intent {
    if (![intent isKindOfClass:ViewWorkInProgressIntent.self]) {
        [NSException raise:NSInvalidArgumentException format:@"Unhandled intent type."];
    }
    return [ViewWorkInProgresIntentHandler new];
}

@end
