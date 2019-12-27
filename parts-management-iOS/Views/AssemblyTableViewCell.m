//
//  AssemblyTableViewCell.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-22.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "AssemblyTableViewCell.h"
#import "Assembly.h"

@implementation AssemblyTableViewCell

#pragma mark - #pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}


#pragma mark - Methods

- (void)populateWithAssembly:(Assembly *)assembly
{
    [self.textLabel setText:[NSString stringWithFormat:@"%@ - %@", assembly.code, assembly.name]];
    [self.detailTextLabel setText:NSLocalizedString(assembly.progressString, NULL)];
}

@end
