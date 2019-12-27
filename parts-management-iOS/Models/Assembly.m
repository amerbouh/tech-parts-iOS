//
//  Assembly.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-22.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "Assembly.h"
#import "FileSize.h"
#import "Progress.h"
#import <FirebaseFirestore/FirebaseFirestore.h>

@implementation Assembly

#pragma mark - Initialization

- (instancetype)initWithCode:(NSString *)code name:(NSString *)name progress:(Progress)progress projectId:(NSString *)projectId shortDescription:(NSString *)shortDescription cost:(NSNumber *)cost subassembliesCount:(NSNumber *)subassembliesCount designFileSize:(FileSize *)designFileSize designFileDownloadURL:(NSString *)designFileDownloadURL dueDate:(NSDate *)dueDate timestamp:(NSDate *)timestamp lastUpdateTimestamp:(NSDate *)lastUpdateTimestamp
{
    self = [super init];
    if (self) {
        _cost = cost;
        _code = code;
        _name = name;
        _dueDate = dueDate;
        _progress = progress;
        _timestamp = timestamp;
        _projectId = projectId;
        _designFileSize = designFileSize;
        _shortDescription = shortDescription;
        _subassembliesCount = subassembliesCount;
        _lastUpdateTimestamp = lastUpdateTimestamp;
        _designFileDownloadURL = designFileDownloadURL;
    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString *)identifier code:(NSString *)code name:(NSString *)name progress:(Progress)progress projectId:(NSString *)projectId shortDescription:(NSString *)shortDescription cost:(NSNumber *)cost subassembliesCount:(NSNumber *)subassembliesCount designFileSize:(FileSize *)designFileSize designFileDownloadURL:(NSString *)designFileDownloadURL dueDate:(NSDate *)dueDate timestamp:(NSDate *)timestamp lastUpdateTimestamp:(NSDate *)lastUpdateTimestamp
{
    self = [super init];
    if (self) {
        _cost = cost;
        _code = code;
        _name = name;
        _dueDate = dueDate;
        _progress = progress;
        _timestamp = timestamp;
        _projectId = projectId;
        _identifier = identifier;
        _designFileSize = designFileSize;
        _shortDescription = shortDescription;
        _subassembliesCount = subassembliesCount;
        _lastUpdateTimestamp = lastUpdateTimestamp;
        _designFileDownloadURL = designFileDownloadURL;
    }
    return self;
}

+ (instancetype)initWithJSON:(NSDictionary<NSString *,id> *)json
{
    FileSize * designFileSize;
    NSString * identifier = (NSString *) json[@"id"];
    NSString * code = (NSString *) json[@"code"];
    NSString * name = (NSString *) json[@"name"];
    NSNumber * cost = (NSNumber *) json[@"totalCost"];
    NSString * state = (NSString *) json[@"state"];
    NSString * projectId = (NSString *) json[@"projectId"];
    NSString * shortDescription = (NSString *) json[@"shortDescription"];
    NSNumber * subassembliesCount = (NSNumber *) json[@"subassembliesCount"];
    NSString * designFileDownloadURL = (NSString *) json[@"designFileDownloadUrl"];
    FIRTimestamp * dueDate = (FIRTimestamp *) json[@"dueDate"];
    FIRTimestamp * creationDate = (FIRTimestamp *) json[@"createdAt"];
    FIRTimestamp * lastUpdateDate = (FIRTimestamp *) json[@"updatedAt"];
    
    // Get the design file's size, if applicable.
    if (json[@"designFileSize"] != NULL) {
        NSDictionary<NSString *, id> * designFileSizeDict = (NSDictionary<NSString *, id> *) json[@"designFileSize"];
        designFileSize = [FileSize initWithJSON:designFileSizeDict];
    }
    
    // Call the class's initializer.
    return [[Assembly alloc] initWithIdentifier:identifier code:code name:name progress:progress_from_string([state UTF8String]) projectId:projectId shortDescription:shortDescription cost:cost subassembliesCount:subassembliesCount designFileSize:designFileSize designFileDownloadURL:designFileDownloadURL dueDate:dueDate.dateValue timestamp:creationDate.dateValue lastUpdateTimestamp:lastUpdateDate.dateValue];
}

#pragma mark - Methods

- (NSString *)progressString
{
    return [NSString stringWithCString:string_from_progress(self.progress) encoding:NSUTF8StringEncoding];
}

- (NSString *)getFormattedDueDate
{
    NSDateFormatter * dateFormatter = [NSDateFormatter new];
    
    // Configure the date formatter.
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    
    return [dateFormatter stringFromDate:self.dueDate];
}

- (NSString *)getFormattedTotalCost
{
    NSNumberFormatter * numberFormatter = [NSNumberFormatter new];
    
    // Configure the date formatter.
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    return [numberFormatter stringFromNumber:self.cost];
}

- (NSString *)getFormattedCreationDate
{
    NSDateFormatter * dateFormatter = [NSDateFormatter new];
    
    // Configure the date formatter.
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    
    return [dateFormatter stringFromDate:self.timestamp];
}

- (NSString *)getFormattedLastUpdateDate
{
    NSDateFormatter * dateFormatter = [NSDateFormatter new];
    
    // Configure the date formatter.
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    
    return [dateFormatter stringFromDate:self.lastUpdateTimestamp];
}

#pragma mark - Document serializable

- (NSDictionary<NSString *,id> *)toDocumentData
{
    return @{
        @"id": self.identifier,
        @"projectId": self.projectId,
        @"name": self.name,
        @"code": self.code,
        @"state": self.progressString,
        @"totalCost": self.cost,
        @"subassembliesCount": self.subassembliesCount,
        @"shortDescription": self.shortDescription,
        @"dueDate": [FIRTimestamp timestampWithDate:self.dueDate],
        @"createdAt": [FIRTimestamp timestampWithDate:self.timestamp],
        @"updatedAt": [FIRTimestamp timestampWithDate:self.lastUpdateTimestamp]
    };
}

@end
