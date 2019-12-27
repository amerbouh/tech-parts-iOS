//
//  AssemblyDataSource.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-22.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FIRAssemblyFetching.h"
#import "FIRAssemblyDeleting.h"
#import "AssemblyDataSourceDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@class Assembly;

@interface AssemblyDataSource : NSObject <UITableViewDataSource>

@property (weak, nonatomic, nullable) id <AssemblyDataSourceDelegate> delegate;

/** @brief Returns the amount of Project instances managed by the data source object. */
- (NSUInteger)getAssembliesCount;

/**
 @brief Returns the Assembly instance at the provided index path.
 
 @param indexPath An Index Path representing the position of the requested Assembly instance
        in a table view.
 */
- (Assembly * _Nullable)getAssemblyAtIndexPath:(NSIndexPath * _Nonnull)indexPath;

/**
 @brief Deletes the assembly at the given index path.
 
 @param indexPath An NSIndexPath representing the position of the assembly in the array of
                   assemblies managed by the data source.
 */
- (void)deleteAssemblyAtIndexPath:(NSIndexPath *)indexPath;

/** @brief Loads the assemblies using the provided FIRAssemblyFetching instance. */
- (void)loadAssembliesForProjectWithIdentifier:(NSString *)projectIdentifier;

/**
 @brief Filters  the array of projects managed by the data source using the provided
           predicate.

 @param predicateString An NSString representing the name of the assembly the users wants
                       to find.
 */
- (void)filterAssembliesUsingPredicate:(NSString *)predicateString;

/**
 @brief Initializes and returns an instance of the Data Source with the provided parameters.
 
 @param assemblyFetcher A  FIRProjectFetching instance representing the object used to load assembly instances.
 @param assemblyDeleter A  FIRAssemblyDeleting instance representing the object used to delete assembly instances.
 @param cellReuseIdentifier A string representing the identifier of the cells used to display an assembly instance.
 */
- (instancetype)initWithAssemblyFetcher:(id <FIRAssemblyFetching>)assemblyFetcher assemblyDeleter:(id <FIRAssemblyDeleting>)assemblyDeleter cellReuseIdentifier:(NSString *)cellReuseIdentifier;

@end

NS_ASSUME_NONNULL_END
