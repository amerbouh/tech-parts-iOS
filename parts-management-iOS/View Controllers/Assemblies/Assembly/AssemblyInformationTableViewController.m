//
//  AssemblyInformationTableViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-25.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "AssemblyInformationTableViewController.h"
#import "Assembly.h"
#import "Progress.h"

@interface AssemblyInformationTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel * shortDescriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel * nameLabel;
@property (weak, nonatomic) IBOutlet UILabel * nameTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel * codeLabel;
@property (weak, nonatomic) IBOutlet UILabel * codeTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel * stateLabel;
@property (weak, nonatomic) IBOutlet UILabel * stateTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel * dueDateLabel;
@property (weak, nonatomic) IBOutlet UILabel * dueDateTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel * costLabel;
@property (weak, nonatomic) IBOutlet UILabel * costTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel * subassemblyCountLabel;
@property (weak, nonatomic) IBOutlet UILabel * subassemblyCountTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel * creationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel * creationDateTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel * lastUpdateDateLabel;
@property (weak, nonatomic) IBOutlet UILabel * lastUpdateDateTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel * viewAssemblyLabel;
@property (weak, nonatomic) IBOutlet UILabel * downloadCADFileLabel;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView * activityIndicatorView;

@property (weak, nonatomic) IBOutlet UITableViewCell * viewAssemblyTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell * downloadCADFileTableViewCell;


/** @brief Populates the cells displayed by the table view with the View Controller's Assembly instance. */
- (void)populateTableViewCells;

/** @brief Configures the static labels displayed by the table view. */
- (void)configureTableViewLabels;

/** @brief Configures the state of the cell used to download the CAD File associated with the View Controller's Assembly instance. */
- (void)configureDownloadCADFileTableViewCellState;

@end

@implementation AssemblyInformationTableViewController

#pragma mark - View's lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self configure];
    [self populateTableViewCells];
    [self configureTableViewLabels];
    [self configureDownloadCADFileTableViewCellState];
}

#pragma mark - Methods

- (void)configure
{
    [self.activityIndicatorView setHidden:YES];
}

- (void)populateTableViewCells
{
    [self.nameLabel setText:self.assembly.name];
    [self.codeLabel setText:self.assembly.code];
    [self.shortDescriptionLabel setText:self.assembly.shortDescription];
    [self.stateLabel setText:NSLocalizedString(self.assembly.progressString, NULL)];
    [self.dueDateLabel setText:self.assembly.getFormattedDueDate];
    [self.costLabel setText:[self.assembly getFormattedTotalCost]];
    [self.subassemblyCountLabel setText:[NSString localizedStringWithFormat:NSLocalizedStringFromTable(@"subassembliesCount", @"Pluralization", NULL), self.assembly.subassembliesCount.intValue]];
    [self.creationDateLabel setText:self.assembly.getFormattedCreationDate];
    [self.lastUpdateDateLabel setText:self.assembly.getFormattedLastUpdateDate];
}

- (void)configureTableViewLabels
{
    [self.nameTitleLabel setText:NSLocalizedString(@"name", NULL)];
    [self.codeTitleLabel setText:NSLocalizedString(@"code", NULL)];
    [self.stateTitleLabel setText:NSLocalizedString(@"state", NULL)];
    [self.dueDateTitleLabel setText:NSLocalizedString(@"dueDate", NULL)];
    [self.costTitleLabel setText:NSLocalizedString(@"totalCost", NULL)];
    [self.subassemblyCountTitleLabel setText:NSLocalizedString(@"subassemblyCount", NULL)];
    [self.creationDateTitleLabel setText:NSLocalizedString(@"createdAt", NULL)];
    [self.lastUpdateDateTitleLabel setText:NSLocalizedString(@"lastEditedAt", NULL)];
    [self.viewAssemblyLabel setText:NSLocalizedString(@"viewAssembly", NULL)];
    [self.downloadCADFileLabel setText:NSLocalizedString(@"downloadCadFile", NULL)];
}

- (void)configureDownloadCADFileTableViewCellState
{
    if (self.assembly.designFileDownloadURL == NULL) {
        [self.viewAssemblyLabel setAlpha:0.5];
        [self.downloadCADFileLabel setAlpha:0.5];
        [self.viewAssemblyTableViewCell setUserInteractionEnabled:NO];
        [self.downloadCADFileTableViewCell setUserInteractionEnabled:NO];
    } else {
        [self.viewAssemblyLabel setAlpha:1];
        [self.downloadCADFileLabel setAlpha:1];
        [self.viewAssemblyTableViewCell setUserInteractionEnabled:YES];
        [self.downloadCADFileTableViewCell setUserInteractionEnabled:YES];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 1  :
            return NSLocalizedString(@"general", NULL);
            
        case 2:
            return NSLocalizedString(@"production", NULL);
            
        case 3:
            return NSLocalizedString(@"timestamps", NULL);
            
        default:
            return NULL;
    }
}

@end
