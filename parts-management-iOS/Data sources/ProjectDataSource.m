//
//  ProjectDataSource.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-14.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "ProjectDataSource.h"
#import "Project.h"
#import "ProjectTableViewCell.h"

@interface ProjectDataSource ()

/** An array representing the list of projects managed by the data source instance. */
@property (strong, nonatomic, nonnull) NSArray<Project *> * projects;

/** An array representing the list of filtered projects managed by the data source instance. */
@property (strong, nonatomic, nonnull) NSArray<Project *> * filteredProjects;

/** A FIRProjectFetching conforming object responsible for fetching Project instances from the database. */
@property (strong, nonatomic) id <FIRProjectFetching> projectFetcher;

/** A FIRProjectDeleting conforming object responsible for deleting Project instances on the database. */
@property (strong, nonatomic) id <FIRProjectDeleting> projectDeleter;

/** A string representing the reuse identifier of the cells used to display a project. */
@property (strong, nonatomic, nonnull) NSString * cellReuseIdentifier;

@end

@implementation ProjectDataSource

#pragma mark - Initialization

- (instancetype)initWithProjectFetcher:(id<FIRProjectFetching>)projectFetcher projectDeleter:(id<FIRProjectDeleting>)projectDeleter cellReuseIdentifier:(NSString *)cellReuseIdentifier
{
    self = [super init];
    if (self) {
        _projects = [NSArray new];
        _projectFetcher = projectFetcher;
        _projectDeleter = projectDeleter;
        _cellReuseIdentifier = cellReuseIdentifier;
    }
    return self;
}

#pragma mark - Methods

- (void)loadProjects
{
    __weak ProjectDataSource * weakSelf = self;

    // Start observing projects listed on the Cloud Firestore database.
    [self.projectFetcher observeProjects:^(NSArray<Project *> * _Nullable projects, NSError * _Nullable error) {
        if (error != nil) { [weakSelf.delegate onFetchFailedWithError:error] ; return; }
        
        // Update the Projects array.
        weakSelf.projects = projects;
        
        // Inform the delegate that the projects were fetched.
        [weakSelf.delegate onFetchCompleted];
    }];
}

- (NSUInteger)getProjectsCount
{
    return [self.projects count];
}

- (Project *)getProjectAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate.isFiltering) {
        return self.filteredProjects[indexPath.row];
    }
    return self.projects[indexPath.row];
}

- (void)filterProjectsUsingPredicate:(NSString *)predicateString
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", predicateString];
    self.filteredProjects = [self.projects filteredArrayUsingPredicate:predicate];
}

- (void)deleteProjectAtIndexPath:(NSIndexPath *)indexPath
{
    Project * project;
    
    // Initialize the Project instance.
    if (self.delegate.isFiltering) {
        project = [self.filteredProjects objectAtIndex:indexPath.row];
    } else {
        project = [self.projects objectAtIndex:indexPath.row];
    }
    
    // Create a weak reference to the data source to avoid strong reference cycles.
    __weak ProjectDataSource * weakSelf = self;
    
    // Remove the project from the Cloud Firestore database.
    [self.projectDeleter deleteProjectWithIdentifier:project.identifier completionHandler:^(NSError * _Nullable error) {
        if (error) { [weakSelf.delegate onDeletionFailedWithError:error]; }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.delegate isFiltering]) {
        return self.filteredProjects.count;
    }
    return self.projects.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ProjectTableViewCell * cell = (ProjectTableViewCell *) [tableView dequeueReusableCellWithIdentifier:self.cellReuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Project * project;
    
    if ([self.delegate isFiltering]) {
        project = self.filteredProjects[indexPath.row];
    } else {
        project = self.projects[indexPath.row];
    }
    
    [cell populateWithProject:project];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate onDeleteProjectAtIndexPath:indexPath];
}

@end
