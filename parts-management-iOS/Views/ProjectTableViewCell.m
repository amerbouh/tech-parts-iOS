//
//  ProjectTableViewCell.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-14.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "ProjectTableViewCell.h"
#import "Project.h"

@implementation ProjectTableViewCell

#pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

#pragma mark - methods

- (void)populateWithProject:(Project *)project
{
    [self.textLabel setText:project.name];
    [self.detailTextLabel setText:project.challengeName];
}

@end
