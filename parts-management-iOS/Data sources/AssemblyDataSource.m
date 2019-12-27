//
//  AssemblyDataSource.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-22.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "AssemblyDataSource.h"
#import "Assembly.h"
#import "AssemblyTableViewCell.h"

@interface AssemblyDataSource ()

/** An array representing the list of assemblies managed by the data source instance. */
@property (strong, nonatomic, nonnull) NSArray<Assembly *> * assemblies;

/** An array representing the list of filtered assemblies managed by the data source instance. */
@property (strong, nonatomic, nonnull) NSArray<Assembly *> * filteredAssemblies;

/** A FIRAssemblyFetching conforming object responsible for fetching Assembly instances from the database. */
@property (strong, nonatomic) id <FIRAssemblyFetching> assemblyFetcher;

/** A FIRAssemblyDeleting conforming object responsible for deleting Assembly instances from the database. */
@property (strong, nonatomic) id <FIRAssemblyDeleting> assemblyDeleter;

/** A string representing the reuse identifier of the cells used to display an assembly. */
@property (strong, nonatomic, nonnull) NSString * cellReuseIdentifier;

@end

@implementation AssemblyDataSource

#pragma mark - Initialization

- (instancetype)initWithAssemblyFetcher:(id<FIRAssemblyFetching>)assemblyFetcher assemblyDeleter:(id<FIRAssemblyDeleting>)assemblyDeleter cellReuseIdentifier:(NSString *)cellReuseIdentifier
{
    self = [super init];
    if (self) {
        _assemblies = [NSArray new];
        _assemblyFetcher = assemblyFetcher;
        _assemblyDeleter = assemblyDeleter;
        _cellReuseIdentifier = cellReuseIdentifier;
    }
    return self;
}

#pragma mark - Methods

- (NSUInteger)getAssembliesCount
{
    return self.assemblies.count;
}

- (Assembly *)getAssemblyAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.assemblies objectAtIndex:indexPath.row];
}

- (void)deleteAssemblyAtIndexPath:(NSIndexPath *)indexPath
{
    Assembly * assembly;
    
    // Initialize the Assembly instance.
    if (self.delegate.isFiltering) {
        assembly = [self.filteredAssemblies objectAtIndex:indexPath.row];
    } else {
        assembly = [self.assemblies objectAtIndex:indexPath.row];
    }
    
    // Create a weak reference to the data source to avoid strong reference cycles.
    __weak AssemblyDataSource * weakSelf = self;
    
    // Remove the project from the Cloud Firestore database.
    [self.assemblyDeleter deleteAssemblyWithIdentifier:assembly.identifier completionHandler:^(NSError * _Nullable error) {
        if (error) { [weakSelf.delegate onDeletionFailedWithError:error]; }
    }];
}

- (void)filterAssembliesUsingPredicate:(NSString *)predicateString
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", predicateString];
    self.filteredAssemblies = [self.assemblies filteredArrayUsingPredicate:predicate];
}

- (void)loadAssembliesForProjectWithIdentifier:(NSString *)projectIdentifier
{
    __weak AssemblyDataSource * weakSelf = self;

    // Start observing projects listed on the Cloud Firestore database.
    [self.assemblyFetcher observeAssembliesForProjectWithIdentifier:projectIdentifier completionHandler:^(NSArray<Assembly *> * _Nullable assemblies, NSError * _Nullable error) {
        if (error) { [weakSelf.delegate onFetchFailedWithError:error]; return; }
        
        // Update the Assemblies array.
        weakSelf.assemblies = assemblies;
        
        // Inform the delegate that the assemblies were fetched.
        [weakSelf.delegate onFetchCompleted];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.delegate.isFiltering) {
        return self.filteredAssemblies.count;
    }
    return self.assemblies.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    AssemblyTableViewCell * cell = (AssemblyTableViewCell *) [tableView dequeueReusableCellWithIdentifier:self.cellReuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Assembly * assembly = [self.assemblies objectAtIndex:indexPath.row];
    
    if (self.delegate.isFiltering) {
        assembly = [self.filteredAssemblies objectAtIndex:indexPath.row];
    }
    
    [cell populateWithAssembly:assembly];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate onDeleteAssemblyAtIndexPath:indexPath];
}

@end
