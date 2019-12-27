//
//  ProjectInformationTableViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import <FirebaseStorage/FirebaseStorage.h>
#import "Project.h"
#import "CADFileRepository.h"
#import "ProjectInformationTableViewController.h"
#import "UIViewController+PresentErrorAlertController.h"

@interface ProjectInformationTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel * descriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel * seasonTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel * seasonSubtitleLabel;

@property (weak, nonatomic) IBOutlet UILabel * robotNameTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel * robotNameSubtitleLabel;

@property (weak, nonatomic) IBOutlet UILabel * challengeNameTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel * challengeNameSubtitleLabel;

@property (weak, nonatomic) IBOutlet UILabel * authorTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel * authorSubtitleLabel;

@property (weak, nonatomic) IBOutlet UILabel * costTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel * costSubtitleLabel;

@property (weak, nonatomic) IBOutlet UILabel * assembliesCountTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel * assembliesCountSubtitleLabel;

@property (weak, nonatomic) IBOutlet UILabel * creationDateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel * creationDateSubtitleLabel;

@property (weak, nonatomic) IBOutlet UILabel * lastUpdateDateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel * lastUpdateDateSubtitleLabel;

@property (weak, nonatomic) IBOutlet UILabel * viewRobotLabel;
@property (weak, nonatomic) IBOutlet UILabel * downloadCADFileLabel;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView * activityIndicatorView;

@property (weak, nonatomic) IBOutlet UITableViewCell * viewRobotTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell * downloadCADFileTableViewCell;

/** A FIRStorageDownloadTask  instance representing the current download task. */
@property (strong, nonatomic, nullable) FIRStorageDownloadTask * currentDownloadTask;

/** @brief Configures the initial state of the view managed by the View Controller. */
- (void)configure;

/** @brief Adjusts the user interface to communicate a loading state to the user. */
- (void)enterLoadingState;

/** @brief Adjusts the user interface to communicate a normal state to the user. */
- (void)exitLoadingState;

/** @brief Attempts to download the CAD File associated with the View Controller's Project instance. */
- (void)downloadProjectCADFile;

/** @brief Populates the cells displayed by the table view with the View Controller's Project instance. */
- (void)populateTableViewCells;

/** @brief Configures the static labels displayed by the table view. */
- (void)configureTableViewLabels;

/** @brief Configures the state of the cell used to download the CAD File associated with the View Controller's Project instance. */
- (void)configureDownloadCADFileTableViewCellState;

@end

@implementation ProjectInformationTableViewController

#pragma mark - Deinitialization

- (void)dealloc
{
    if (self.currentDownloadTask != NULL) {
        [self.currentDownloadTask cancel];
    }
}

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
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

- (void)enterLoadingState
{
    [self.activityIndicatorView startAnimating];
    [self.downloadCADFileLabel setHidden:YES];
    [self.activityIndicatorView setHidden:NO];
}

- (void)exitLoadingState
{
    [self.activityIndicatorView setHidden:YES];
    [self.activityIndicatorView stopAnimating];
    [self.downloadCADFileLabel setHidden:NO];
}

- (void)downloadProjectCADFile
{
    CADFileRepository * cadFileRepository = [CADFileRepository new];
    
    // Enter the loading state and disable the Edit UIBarButtonItem.
    [self enterLoadingState];
    [self.parentViewController.navigationItem.rightBarButtonItem setEnabled:NO];
    
    // Create a weak reference to the View Controller to avoid strong reference cycles.
    __weak ProjectInformationTableViewController * weakSelf = self;
    
    // Attempt to download the project's CAD File
    self.currentDownloadTask = [cadFileRepository downloadFileWithGCSURI:self.project.designFileDownloadURL fileName:self.project.name completionHandler:^(NSURL * _Nullable localFileURL, NSError * _Nullable error) {
        [weakSelf exitLoadingState];
        [weakSelf.parentViewController.navigationItem.rightBarButtonItem setEnabled:YES];
        
        // Handle the download result.
        if (error != NULL) {
            [weakSelf presentErrorAlertControllerWithMessage:error.localizedDescription];
        } else {
            weakSelf.currentDownloadTask = NULL;
        }
    }];
}

- (void)populateTableViewCells
{
    [self.descriptionLabel setText:self.project.shortDescription];
    [self.seasonSubtitleLabel setText:self.project.season.stringValue];
    [self.robotNameSubtitleLabel setText:self.project.robotName];
    [self.challengeNameSubtitleLabel setText:self.project.challengeName];
    [self.authorSubtitleLabel setText:self.project.authorName];
    [self.costSubtitleLabel setText:[self.project getFormattedTotalCost]];
    [self.assembliesCountSubtitleLabel setText:[NSString localizedStringWithFormat:NSLocalizedStringFromTable(@"assembliesCount", @"Pluralization", NULL), self.project.assembliesCount.intValue]];
    [self.creationDateSubtitleLabel setText:[self.project getFormattedCreationDate]];
    [self.lastUpdateDateSubtitleLabel setText:[self.project getFormattedLastUpdateDate]];
}

- (void)configureTableViewLabels
{
    [self.costTitleLabel setText:NSLocalizedString(@"totalCost", NULL)];
    [self.seasonTitleLabel setText:NSLocalizedString(@"season", NULL)];
    [self.authorTitleLabel setText:NSLocalizedString(@"author", NULL)];
    [self.robotNameTitleLabel setText:NSLocalizedString(@"robotName", NULL)];
    [self.creationDateTitleLabel setText:NSLocalizedString(@"createdAt", NULL)];
    [self.challengeNameTitleLabel setText:NSLocalizedString(@"challengeName", NULL)];
    [self.assembliesCountTitleLabel setText:NSLocalizedString(@"assembliesCount", NULL)];
    [self.lastUpdateDateTitleLabel setText:NSLocalizedString(@"lastEditedAt", NULL)];
    [self.viewRobotLabel setText:NSLocalizedString(@"viewRobot", NULL)];
    [self.downloadCADFileLabel setText:NSLocalizedString(@"downloadCadFile", NULL)];
}

- (void)configureDownloadCADFileTableViewCellState
{
    if (self.project.designFileDownloadURL == NULL) {
        [self.viewRobotLabel setAlpha:0.5];
        [self.downloadCADFileLabel setAlpha:0.5];
        [self.viewRobotTableViewCell setUserInteractionEnabled:NO];
        [self.downloadCADFileTableViewCell setUserInteractionEnabled:NO];
    } else {
        [self.viewRobotLabel setAlpha:1];
        [self.downloadCADFileLabel setAlpha:1];
        [self.viewRobotTableViewCell setUserInteractionEnabled:YES];
        [self.downloadCADFileTableViewCell setUserInteractionEnabled:YES];
    }
}

#pragma mark - Table View delegate

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 4 && indexPath.row == 1) {
        if (!self.project.getShouldAllowDesignFileDownload) {
            [self presentErrorAlertControllerWithMessage:NSLocalizedString(@"fileExceedsDownloadLimit", NULL)];
        } else {
            [self downloadProjectCADFile];
        }
    }
    
    // Deselect the selected cell.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowDesignViewerVCSegue"]) {
        UINavigationController * navigationController = (UINavigationController *) segue.destinationViewController;
        [navigationController.visibleViewController.navigationItem setTitle:self.project.name];
    }
}

@end
