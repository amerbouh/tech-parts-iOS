//
//  UserRepository.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "UserRepository.h"
#import "User.h"
#import "Realm.h"
#import "FirebaseFirestore.h"

@interface UserRepository ()

@property (nonnull, nonatomic) FIRFirestore * database;

@end

@implementation UserRepository

static NSString * USERS_COLLECTION_NAME = @"users";

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        _database = [FIRFirestore firestore];
    }
    return self;
}

#pragma mark - Methods

- (void)saveUser:(User *)user completionHandler:(void (^)(void))completionHandler
{
    RLMRealm * realm = [RLMRealm defaultRealm];
    
    // Save the User instance on the device's local storage.
    [realm transactionWithBlock:^{
        [realm addObject:user];
        
        // Call the completion handler.
        completionHandler();
    }];
}

- (void)getUserWithIdentifier:(NSString *)uid completionHandler:(void (^)(User * _Nullable, NSError * _Nullable))completionHandler
{
    FIRDocumentReference * userDocRef = [[self.database collectionWithPath:USERS_COLLECTION_NAME] documentWithPath:uid];
    
    // Get the document's data.
    [userDocRef getDocumentWithCompletion:^(FIRDocumentSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(NULL, error);
        } else {
            if (!snapshot.exists) return;
            
            // Create a User instance from the document's data.
            User * user = [User initWithJSON:snapshot.data];
            
            // Call the completion handler and pass the created user instance.
            completionHandler(user, NULL);
        }
    }];
}

@end
