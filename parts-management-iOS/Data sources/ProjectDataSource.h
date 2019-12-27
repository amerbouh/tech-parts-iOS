//
//  ProjectDataSource.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-14.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FIRProjectFetching.h"
#import "FIRProjectDeleting.h"
#import "ProjectDataSourceDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@class Project;
@class ProjectRepository;

@interface ProjectDataSource : NSObject <UITableViewDataSource>

@property (weak, nonatomic, nullable) id <ProjectDataSourceDelegate> delegate;

/** @brief Loads the projects using the provided FIRProjectFetching instance. */
- (void)loadProjects;

/**
 @brief Deletes the project at the given index path.
 
 @param indexPath An NSIndexPath representing the position of the project in the array of
                   projects managed by the data source.
 */
- (void)deleteProjectAtIndexPath:(NSIndexPath *)indexPath;

/**
 @brief Filters  the array of projects managed by the data source using the provided
           predicate.

 @param predicateString An NSString representing the name of the project the users wants
                 to find.
 */
- (void)filterProjectsUsingPredicate:(NSString *)predicateString;

/** @brief Returns the amount of Project instances managed by the data source object. */
- (NSUInteger)getProjectsCount;

/**
 @brief Returns the Project instance at the provided index path.
 
 @param indexPath An Index Path representing the position of the requested Project instance
        in a table view.
 */
- (Project * _Nullable)getProjectAtIndexPath:(NSIndexPath * _Nonnull)indexPath;

/**
 @brief Initializes and returns an instance  of the Data Source with the provided parameters.
 
 @param projectFetcher A  FIRProjectFetching instance representing the object used to load project instances.
 @param projectDeleter A FIRProjectDeleting instance representing the object used to delete project instances.
 @param cellReuseIdentifier A string representing the identifier of the cells used to display a Project instance.
 */
- (instancetype)initWithProjectFetcher:(id <FIRProjectFetching>)projectFetcher projectDeleter:(id <FIRProjectDeleting>)projectDeleter cellReuseIdentifier:(NSString *)cellReuseIdentifier;

@end

NS_ASSUME_NONNULL_END
