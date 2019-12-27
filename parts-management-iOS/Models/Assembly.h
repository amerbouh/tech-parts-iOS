//
//  Assembly.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-22.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Progress.h"
#import "JSONObjectPayload.h"
#import "FIRDocumentSerializable.h"

NS_ASSUME_NONNULL_BEGIN

@class FileSize;

@interface Assembly : NSObject <JSONObjectPayload, FIRDocumentSerializable>

/** A string respresenting the unique identifier of the assembly. */
@property (strong, nonatomic, nonnull) NSString * identifier;

/** A string representing the code of the assembly. */
@property (strong, nonatomic, nonnull) NSString * code;

/** A string representing the name of the assembly. */
@property (strong, nonatomic, nonnull) NSString * name;

/** A Progress enum case representing the progress of the assembly. */
@property (assign, nonatomic) Progress progress;

/** A string representing the progress of the assembly. */
@property (assign, readonly) NSString * progressString;

/** A string representing the identifier of the project the assembly belongs to. */
@property (strong, nonatomic, nonnull) NSString * projectId;

/** A string representing the description of the assembly. */
@property (strong, nonatomic, nonnull) NSString * shortDescription;

/** A string representing the cost of the assembly. */
@property (strong, nonatomic, nonnull) NSNumber * cost;

/** A string representing the amount of assemblies the assembly is made of. */
@property (strong, nonatomic, nonnull) NSNumber * subassembliesCount;

/** A FileSize representing the size of the design file associated with  the assembly. */
@property (strong, nonatomic, nullable) FileSize * designFileSize;

/** A string representing the download URL of the design file associated with the assembly. */
@property (strong, nonatomic, nullable) NSString * designFileDownloadURL;

/** A date object representing the due date of the assembly.  */
@property (strong, nonatomic, nonnull) NSDate * dueDate;

/** A date object representing creation date of the assembly.  */
@property (strong, nonatomic, nonnull) NSDate * timestamp;

/** A date object representing the last update date of the assembly.  */
@property (strong, nonatomic, nonnull) NSDate * lastUpdateTimestamp;

/** @brief Returns the due date of the assembly based on local's date format. */
- (NSString *)getFormattedDueDate;

/** @brief Returns the total cost of production of the assembly based on local's currency format. */
- (NSString *)getFormattedTotalCost;

/** @brief Returns the creation date of the assembly based on local's date format. */
- (NSString *)getFormattedCreationDate;

/** @brief Returns the last update date of the assembly based on local's date format. */
- (NSString *)getFormattedLastUpdateDate;

/**
 @brief Initializes a new Assembly instance with the provided parameters.
 
 @param cost A string representing the download URL of the design file associated with project.
 @param code A string representing the code of the assembly.
 @param name A string representing the name of the assembly.
 @param dueDate A date object representing the due date of the assembly.
 @param progress A Progress enum case representing the progress of the assembly.
 @param projectId A string representing the identifier of the project the assembly belongs to.
 @param designFileSize A FileSize representing the size of the design file associated with  the assembly.
 @param shortDescription A FileSize representing the size of the design file associated with  the assembly.
 @param subassembliesCount A string representing the amount of assemblies the assembly is made of.
 @param designFileDownloadURL A string representing the download URL of the design file associated with the assembly.
 @param timestamp A date object representing creation date of the assembly.
 @param lastUpdateTimestamp A date object representing the last update date of the assembly.
*/
- (instancetype)initWithCode:(NSString * _Nonnull)code name:(NSString * _Nonnull)name progress:(Progress)progress projectId:(NSString * _Nonnull)projectId shortDescription:(NSString * _Nonnull)shortDescription cost:(NSNumber * _Nonnull)cost subassembliesCount:(NSNumber * _Nonnull)subassembliesCount designFileSize:(FileSize * _Nullable)designFileSize designFileDownloadURL:(NSString * _Nullable)designFileDownloadURL dueDate:(NSDate * _Nonnull)dueDate timestamp:(NSDate * _Nonnull)timestamp lastUpdateTimestamp:(NSDate * _Nonnull)lastUpdateTimestamp;

/**
 @brief Initializes a new Assembly instance with the provided parameters.
 
 @param cost A string representing the download URL of the design file associated with project.
 @param code A string representing the code of the assembly.
 @param name A string representing the name of the assembly.

 @param dueDate A date object representing the due date of the assembly.
 @param progress A Progress enum case representing the progress of the assembly.
 @param projectId A string representing the identifier of the project the assembly belongs to.
 @param identifier A string respresenting the unique identifier of the assembly.
 @param designFileSize A FileSize representing the size of the design file associated with  the assembly.
 @param shortDescription A FileSize representing the size of the design file associated with  the assembly.
 @param subassembliesCount A string representing the amount of assemblies the assembly is made of.
 @param designFileDownloadURL A string representing the download URL of the design file associated with the assembly.
 @param timestamp A date object representing creation date of the assembly.
 @param lastUpdateTimestamp A date object representing the last update date of the assembly.
*/
- (instancetype)initWithIdentifier:(NSString * _Nonnull)identifier code:(NSString * _Nonnull)code name:(NSString * _Nonnull)name progress:(Progress)progress projectId:(NSString * _Nonnull)projectId shortDescription:(NSString * _Nonnull)shortDescription cost:(NSNumber * _Nonnull)cost subassembliesCount:(NSNumber * _Nonnull)subassembliesCount designFileSize:(FileSize * _Nullable)designFileSize designFileDownloadURL:(NSString * _Nullable)designFileDownloadURL dueDate:(NSDate * _Nonnull)dueDate timestamp:(NSDate * _Nonnull)timestamp lastUpdateTimestamp:(NSDate * _Nonnull)lastUpdateTimestamp;

@end

NS_ASSUME_NONNULL_END
