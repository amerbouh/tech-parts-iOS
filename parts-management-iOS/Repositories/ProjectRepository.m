//
//  ProjectRepository.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "ProjectRepository.h"
#import "Project.h"

@implementation ProjectRepository {
    FIRFirestore * _database;
}

static NSString * PROJECTS_COLLECTION_NAME = @"projects";

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

- (void)createProject:(Project *)project authorUid:(NSString *)authorUid completionHandler:(void (^)(NSError * _Nullable))completionHandler
{
    FIRCollectionReference * projectsCollection = [_database collectionWithPath:PROJECTS_COLLECTION_NAME];
    FIRDocumentReference * projectDocumentRef = [projectsCollection documentWithAutoID];
    
    // Set the project's identifier.
    [project setIdentifier:projectDocumentRef.documentID];
    
    // Create a NSMutableDictionary representing the document data that is being uploaded to Cloud Firestore.
    NSMutableDictionary<NSString *, id> * projectDocumentData = [NSMutableDictionary dictionaryWithDictionary: [project toDocumentData]];
    [projectDocumentData setValue:authorUid forKey:@"authorUid"];
    
    // Upload the document to the Cloud Firestore database.
    [projectDocumentRef setData:projectDocumentData completion:completionHandler];
}

- (void)updateProject:(Project *)project completionHandler:(void (^)(NSError * _Nullable))completionHandler
{
    [project setLastUpdateTimestamp:[NSDate new]];
    
    // Get a reference to the document.
    FIRCollectionReference * projectsCollection = [_database collectionWithPath:PROJECTS_COLLECTION_NAME];
    FIRDocumentReference * projectDocument = [projectsCollection documentWithPath:project.identifier];
    
    // Update the document on the Cloud Firestore database.
    [projectDocument updateData:[project toDocumentData] completion:completionHandler];
}

- (void)deleteProjectWithIdentifier:(NSString *)identifier completionHandler:(void (^)(NSError * _Nullable))completionHandler
{
    FIRCollectionReference * projectsCollection = [_database collectionWithPath:PROJECTS_COLLECTION_NAME];
    FIRDocumentReference * projectDocument = [projectsCollection documentWithPath:identifier];
    
    // Remove the document from the Cloud Firestore database.
    [projectDocument deleteDocumentWithCompletion:completionHandler];
}

- (id<FIRListenerRegistration>)observeProjects:(void (^)(NSArray<Project *> * _Nullable, NSError * _Nullable))completionHandler
{
    FIRQuery * query = [[_database collectionWithPath:PROJECTS_COLLECTION_NAME] queryOrderedByField:@"season" descending:YES];
    return [query addSnapshotListener:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (snapshot == nil) { completionHandler(nil, error) ; return; }
        
        // Get an instance of the documents.
        NSArray<FIRQueryDocumentSnapshot *> * documents = snapshot.documents;
        
        // Create a Project array instance.
        NSMutableArray<Project *> * projects = [NSMutableArray new];
        
        // Loop through each document.
        for (int i = 0; i < documents.count; i++) {
            NSDictionary<NSString *, id> * documentData = documents[i].data;
            
            // Create a Project instance from the document's data.
            Project * project = [Project initWithJSON:documentData];
            
            // Add the created Project instance to the projects array.
            if (project != nil) {
                [projects addObject:project];
            }
        }
        
        // Call the completion handler.
        completionHandler(projects, nil);
    }];
}

@end
