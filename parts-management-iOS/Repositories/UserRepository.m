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

@implementation UserRepository {
    RLMRealm * _realm;
    FIRFirestore * _database;
}

static NSString * USERS_COLLECTION_NAME = @"users";

#pragma mark - Initialization

- (instancetype)initWithRealm:(RLMRealm *)realm firestore:(FIRFirestore *)firestore
{
    self = [super init];
    if (self) {
        _realm    = realm;
        _database = firestore;
    }
    return self;
}

#pragma mark - Methods

- (void)deleteUserWithIdentifier:(NSString *)identifier
{
    User * user = [User objectForPrimaryKey:identifier];
    
    // Verify whether or not the user object we are trying to remove
    // exists.
    if (user == NULL || user.isInvalidated)
    {
        return;
    }
    
    // Remove the appropriate User object from the device's local storage.
    [_realm beginWriteTransaction];
    [_realm deleteObject:user];
    [_realm commitWriteTransaction];
}

- (void)saveUser:(User *)user completionHandler:(void (^)(void))completionHandler
{
    [_realm beginWriteTransaction];
    [_realm addObject:user];
    [_realm commitWriteTransaction];
    
    // Call the completion handler.
    completionHandler();
}

- (void)createProfileForUser:(User *)user completionHandler:(void (^)(NSError * _Nullable))completionHandler
{
    __weak UserRepository * weakSelf = self;
    FIRDocumentReference const * const userDocRef = [[_database collectionWithPath:USERS_COLLECTION_NAME] documentWithPath:user.identifier];
    
    // Save the user's data.
    [userDocRef setData:[user toDocumentData] completion:^(NSError * _Nullable error) {
        if (error) {
            completionHandler(error);
        } else {
            [weakSelf saveUser:user completionHandler:^{
                completionHandler(NULL);
            }];
        }
    }];
    [userDocRef setData:[user toDocumentData] completion:completionHandler];
}

- (void)getUserWithIdentifier:(NSString *)uid completionHandler:(void (^)(User * _Nullable, NSError * _Nullable))completionHandler
{
    User * const user = [User objectForPrimaryKey:uid];
    
    // Check if the user instance already exists ont the device's local
    // storage.
    if (user != NULL)
    {
        completionHandler(user, NULL);
        return;
    }
    
    // Get a reference to the user's record on the remote database.
    FIRDocumentReference const * const userDocRef = [[_database collectionWithPath:USERS_COLLECTION_NAME] documentWithPath:uid];
           
    // Get the document's data.
    [userDocRef getDocumentWithCompletion:^(FIRDocumentSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(NULL, error);
        } else {
            if (!snapshot.exists) {
                NSError * userNotFoundError = [NSError errorWithDomain:NSCocoaErrorDomain code:404 userInfo:@{NSLocalizedDescriptionKey: @"User not found"}];
                
                // Call the completion handler and pass the created error.
                completionHandler(NULL, userNotFoundError);
                
                return;
            }
                   
            // Create a User instance from the document's data.
            User * fetchedUser = [User initWithJSON:snapshot.data];
                   
            // Call the completion handler and pass the created user instance.
            completionHandler(fetchedUser, NULL);
        }
    }];
}

@end
