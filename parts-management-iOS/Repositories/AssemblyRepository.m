//
//  AssemblyRepository.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-23.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "AssemblyRepository.h"
#import "Assembly.h"

@interface AssemblyRepository ()

@property (nonnull, nonatomic) FIRFirestore * database;

@end

@implementation AssemblyRepository

static NSString * ASSEMBLIES_COLLECTION_NAME = @"assemblies";

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

- (void)createAssembly:(Assembly *)assembly completionHandler:(void (^)(NSError * _Nullable))completionHandler
{
    FIRCollectionReference * assembliesCollection = [self.database collectionWithPath:ASSEMBLIES_COLLECTION_NAME];
    FIRDocumentReference * assemblyDocumentRef = [assembliesCollection documentWithAutoID];
    
    // Set the project's identifier.
    [assembly setIdentifier:assemblyDocumentRef.documentID];
    
    // Upload the document to the Cloud Firestore database.
    [assemblyDocumentRef setData:[assembly toDocumentData] completion:completionHandler];
}

- (void)deleteAssemblyWithIdentifier:(NSString *)identifier completionHandler:(void (^)(NSError * _Nullable))completionHandler
{
    FIRCollectionReference * assembliesCollection = [self.database collectionWithPath:ASSEMBLIES_COLLECTION_NAME];
    FIRDocumentReference * assemblyDocument = [assembliesCollection documentWithPath:identifier];
    
    // Remove the document from the Cloud Firestore database.
    [assemblyDocument deleteDocumentWithCompletion:completionHandler];
}

- (id<FIRListenerRegistration>)observeAssembliesForProjectWithIdentifier:(NSString *)projectIdentifier completionHandler:(void (^)(NSArray<Assembly *> * _Nullable, NSError * _Nullable))completionHandler
{
    FIRQuery * query = [[self.database collectionWithPath:ASSEMBLIES_COLLECTION_NAME] queryWhereField:@"projectId" isEqualTo:projectIdentifier];
    return [query addSnapshotListener:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (snapshot == nil) { completionHandler(nil, error) ; return; }
        
        // Get an instance of the documents.
        NSArray<FIRQueryDocumentSnapshot *> * documents = snapshot.documents;
        
        // Create a Project array instance.
        NSMutableArray<Assembly *> * assemblies = [NSMutableArray new];
        
        // Loop through each document.
        for (int i = 0; i < documents.count; i++) {
            NSDictionary<NSString *, id> * documentData = documents[i].data;
            
            // Create an Assembly instance from the document's data.
            Assembly * assembly = [Assembly initWithJSON:documentData];
            
            // Add the created Project instance to the projects array.
            if (assembly != nil) {
                [assemblies addObject:assembly];
            }
        }
        
        // Call the completion handler.
        completionHandler(assemblies, nil);
    }];
}

@end
