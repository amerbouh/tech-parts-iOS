//
//  RegistrationTokenRepository.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2020-05-23.
//  Copyright © 2020 Anas Merbouh. All rights reserved.
//

#import "RegistrationTokenRepository.h"
#import <FirebaseDatabase/FirebaseDatabase.h>

@implementation RegistrationTokenRepository

#pragma mark - Methods

- (void)saveRegistrationToken:(NSString *)registrationToken forUserWithIdentifier:(NSString *)userIdentifier
{
    FIRDatabaseReference const * const fcmTokensRef = [[[FIRDatabase database] reference] child:@"fcmTokens"];
    
    // Set the registration token for the user with the given identifier.
    [[fcmTokensRef child:userIdentifier] setValue:registrationToken];
}

@end
