//
//  Project.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-14.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileSize.h"
#import "JSONObjectPayload.h"
#import "FIRDocumentSerializable.h"

NS_ASSUME_NONNULL_BEGIN

@class FileSize;

@interface Project : NSObject <JSONObjectPayload, FIRDocumentSerializable>

/** A string respresenting the unique identifier of the project. */
@property (strong, nonatomic, nonnull) NSString * identifier;

/** A string representing the name of the project. */
@property (strong, nonatomic, nonnull) NSString * name;

/** A number representing the total cost of the project. */
@property (strong, nonatomic, nonnull) NSNumber * cost;

/** A number representing the season of the project. */
@property (strong, nonatomic, nonnull) NSNumber * season;

/** A number representing the amount of assemblies of the project. */
@property (strong, nonatomic, nonnull) NSNumber * assembliesCount;

/** A string representing the name of the author of the project. */
@property (strong, nonatomic, nullable) NSString * authorName;

/** A string representing the name of the robot. */
@property (strong, nonatomic, nullable) NSString * robotName;

/** A string representing the description of the project. */
@property (strong, nonatomic, nonnull) NSString * shortDescription;

/** A string representing the name of the FRC challenge the project is created for. */
@property (strong, nonatomic, nonnull) NSString * challengeName;

/** A FileSize representing the size of the design file associated with  the project. */
@property (strong, nonatomic, nullable) FileSize * designFileSize;

/** A string representing the download URL of the design file associated with the project. */
@property (strong, nonatomic, nullable) NSString * designFileDownloadURL;

/** A date object representing creation date of the project.  */
@property (strong, nonatomic, nonnull) NSDate * timestamp;

/** A date object representing the last update date of the project.  */
@property (strong, nonatomic, nonnull) NSDate * lastUpdateTimestamp;

/** Returns the total cost of production of the robot based on local's currency format. */
- (NSString *)getFormattedTotalCost;

/** Returns the creation date of the project based on local's date format. */
- (NSString *)getFormattedCreationDate;

/** Returns the last update date of the project based on local's date format. */
- (NSString *)getFormattedLastUpdateDate;

/** Returns whether or not the size of the design file associated with the project exceeds the over-the-fly downloadl limit. */
- (BOOL)getShouldAllowDesignFileDownload;

/**
 @brief Initializes a new Project instance with the provided parameters.
 
 @param name A string representing the name of the project.
 @param robotName A string representing the name of the robot.
 @param shortDescription A string representing the description of the project.
 @param challengeName A string representing the name of the FRC challenge the project is created for.
 @param timestamp A date object representing creation date of the project.
*/
- (instancetype)initWithName:(NSString * _Nonnull)name cost:(NSNumber * _Nonnull)cost season:(NSNumber * _Nonnull)season assembliesCount:(NSNumber * _Nonnull)assembliesCount robotName:(NSString * _Nonnull)robotName authorName:(NSString * _Nonnull)authorName shortDescription:(NSString * _Nonnull)shortDescription challengeName:(NSString * _Nonnull)challengeName timestamp:(NSDate * _Nonnull)timestamp lastUpdateTimestamp:(NSDate * _Nonnull)lastUpdateTimestamp;

/**
 @brief Initializes a new Project instance with the provided parameters.
 
 @param identifier A string respresenting the unique identifier of the project.
 @param name A string representing the name of the project.
 @param robotName A string representing the name of the robot.
 @param shortDescription A string representing the description of the project.
 @param challengeName A string representing the name of the FRC challenge the project is created for.
 @param designFileSize A FileSize representing the size of the design file associated with  the project.
 @param designFileDownloadURL A string representing the download URL of the design file associated with project.
 @param timestamp A date object representing creation date of the project.
*/
- (instancetype)initWithIdentifier:(NSString * _Nonnull)identifier name:(NSString * _Nonnull)name cost:(NSNumber * _Nonnull)cost season:(NSNumber * _Nonnull)season assembliesCount:(NSNumber * _Nonnull)assembliesCount robotName:(NSString * _Nonnull)robotName authorName:(NSString * _Nonnull)authorName shortDescription:(NSString * _Nonnull)shortDescription challengeName:(NSString * _Nonnull)challengeName designFileSize:(FileSize *)designFileSize designFileDownloadURL:(NSString * _Nullable)designFileDownloadURL timestamp:(NSDate * _Nonnull)timestamp lastUpdateTimestamp:(NSDate * _Nonnull)lastUpdateTimestamp;

@end

NS_ASSUME_NONNULL_END
