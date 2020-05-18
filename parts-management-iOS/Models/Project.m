//
//  Project.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-14.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "Project.h"
#import "Reachability.h"
#import "FirebaseFirestore.h"

@implementation Project

#pragma mark - Initialization

- (instancetype)initWithName:(NSString *)name cost:(NSNumber *)cost season:(NSNumber *)season assembliesCount:(NSNumber *)assembliesCount robotName:(NSString *)robotName shortDescription:(NSString *)shortDescription challengeName:(NSString *)challengeName timestamp:(NSDate *)timestamp lastUpdateTimestamp:(NSDate *)lastUpdateTimestamp
{
    self = [super init];
    if (self) {
        _name = name;
        _cost = cost;
        _season = season;
        _timestamp = timestamp;
        _robotName = robotName;
        _challengeName = challengeName;
        _assembliesCount = assembliesCount;
        _shortDescription = shortDescription;
        _lastUpdateTimestamp = lastUpdateTimestamp;
    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString *)identifier name:(NSString *)name cost:(NSNumber *)cost season:(NSNumber *)season assembliesCount:(NSNumber *)assembliesCount robotName:(NSString *)robotName authorName:(NSString *)authorName shortDescription:(NSString *)shortDescription challengeName:(NSString *)challengeName designFileSize:(FileSize *)designFileSize designFileDownloadURL:(NSString *)designFileDownloadURL timestamp:(NSDate *)timestamp lastUpdateTimestamp:(NSDate *)lastUpdateTimestamp
{
    self = [super init];
    if (self) {
        _name = name;
        _cost = cost;
        _season = season;
        _timestamp = timestamp;
        _robotName = robotName;
        _identifier = identifier;
        _authorName = authorName;
        _challengeName = challengeName;
        _designFileSize = designFileSize;
        _designFileDownloadURL = designFileDownloadURL;
        _assembliesCount = assembliesCount;
        _shortDescription = shortDescription;
        _lastUpdateTimestamp = lastUpdateTimestamp;
    }
    return self;
}

+ (instancetype)initWithJSON:(NSDictionary<NSString *,id> *)json
{
    FileSize * designFileSize;
    NSString * identifier = (NSString *) json[@"id"];
    NSString * name = (NSString *) json[@"name"];
    NSNumber * cost = (NSNumber *) json[@"totalCost"];
    NSNumber * season = (NSNumber *) json[@"season"];
    NSString * robotName = (NSString *) json[@"robotName"];
    NSString * challengeName = (NSString *) json[@"challengeName"];
    NSString * shortDescription = (NSString *) json[@"shortDescription"];
    NSString * designFileDownloadURL = (NSString *) json[@"designFileDownloadUrl"];
    NSNumber * assembliesCount = (NSNumber *) json[@"assembliesCount"];
    FIRTimestamp * creationDate = (FIRTimestamp *) json[@"createdAt"];
    FIRTimestamp * lastUpdateDate = (FIRTimestamp *) json[@"updatedAt"];
    
    // Get the author's name.
    NSDictionary<NSString *, id> * author = (NSDictionary *) json[@"author"];
    NSString * authorName = (NSString *) [author valueForKey:@"name"];
    
    // Get the design file's size, if applicable.
    if (json[@"designFileSize"] != NULL) {
        NSDictionary<NSString *, id> * designFileSizeDict = (NSDictionary<NSString *, id> *) json[@"designFileSize"];
        designFileSize = [FileSize initWithJSON:designFileSizeDict];
    }
    
    // Call the class's initializer.
    return [[Project alloc] initWithIdentifier:identifier name:name cost:cost season:season assembliesCount:assembliesCount robotName:robotName authorName:authorName shortDescription:shortDescription challengeName:challengeName designFileSize:designFileSize designFileDownloadURL:designFileDownloadURL timestamp:creationDate.dateValue lastUpdateTimestamp:lastUpdateDate.dateValue];
}

#pragma mark - Methods

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

- (BOOL)getShouldAllowDesignFileDownload
{
    Reachability * reachability = [Reachability reachabilityForInternetConnection];
    
    // Get the current network status.
    [reachability startNotifier];
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    // If the user's device connection is cellular, do not allow downloads of files
    // exceeding 15MB.
    if (status == ReachableViaWWAN) {
        return self.designFileSize.value.floatValue <= 15;
    }
    
    return YES;
}

- (NSDictionary<NSString *, id> *)toDocumentData
{
    return @{
        @"id": self.identifier,
        @"name": self.name,
        @"season": self.season,
        @"totalCost": self.cost,
        @"robotName": self.robotName,
        @"challengeName": self.challengeName,
        @"shortDescription": self.shortDescription,
        @"assembliesCount": self.assembliesCount,
        @"createdAt": [FIRTimestamp timestampWithDate:self.timestamp],
        @"updatedAt": [FIRTimestamp timestampWithDate:self.lastUpdateTimestamp],
    };
}

@end
