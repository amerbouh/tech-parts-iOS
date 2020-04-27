//
//  ViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-12.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "ProjectListViewController.h"
#import "Operation.h"
#import "MessageView.h"
#import "NSString+Empty.h"
#import "ProjectDataSource.h"
#import "ProjectRepository.h"
#import "ProjectTableViewCell.h"
#import "ProjectDetailViewController.h"
#import "UITableView+UITableView_BackgroundView.h"
#import "UIViewController+PresentErrorAlertController.h"

@interface ProjectListViewController ()

/** The UITableView instance used to display a list of projects to the user. */
@property (weak, nonatomic) IBOutlet UITableView * tableView;

/** The data source object used by the Table View instance to display a list of projects. */
@property (strong, nonatomic, nonnull) ProjectDataSource * dataSource;

/** A UISearchController instance representing the search bar displayed under the controller's navigation bar. */
@property (strong, nonatomic, nonnull) UISearchController * searchController;

/** @brief Prepares the UITableView instance used to display a list of projects. */
- (void)configureTableView;

/** @brief Configures the navigation bar used to displayed various actions. */
- (void)configureNavigationBar;

/** @brief Prepares the UISearchController instance used  to display search results. */
- (void)configureSearchController;

@end

@implementation ProjectListViewController

static NSString * _cellReuseIdentifier = @"ProjectTableViewCell";
static NSString * _showProjectDetailSegueIdentifier = @"ShowProjectDetailVCSegue";

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        ProjectRepository * projectRepository = [ProjectRepository new];
        _dataSource = [[ProjectDataSource alloc] initWithProjectFetcher:projectRepository
                                                         projectDeleter:projectRepository
                                                    cellReuseIdentifier:_cellReuseIdentifier];
        _dataSource.delegate = self;
        _searchController = [[UISearchController alloc] initWithSearchResultsController:NULL];
        _searchController.searchResultsUpdater = self;
    }
    return self;
}

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Register cell classes...
    [self.tableView registerClass:[ProjectTableViewCell class] forCellReuseIdentifier:_cellReuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self configureTableView];
    [self configureNavigationBar];
    [self configureSearchController];
    [self.dataSource loadProjects];
    [self.navigationItem setSearchController:self.searchController];
}

#pragma mark - Methods

- (void)configureTableView
{
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self.dataSource];
}

- (void)configureNavigationBar
{
    if ([self.authorizationManager authorizeOperation:CREATE_PROJECT] == NO)
    {
        [self.navigationItem setRightBarButtonItem:NULL];
    } /* Hide the right bar button item. */
}

- (void)configureSearchController
{
    [self setDefinesPresentationContext:YES];
    [self.searchController setObscuresBackgroundDuringPresentation:NO];
}

#pragma mark - Search Results Updating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [self.dataSource filterProjectsUsingPredicate:searchController.searchBar.text];
    [self.tableView reloadData];
}

#pragma mark - Table View delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Project * selectedProject = [self.dataSource getProjectAtIndexPath:indexPath];
    
    // Navigate to the Project Detail View Controller.
    [self performSegueWithIdentifier:_showProjectDetailSegueIdentifier sender:selectedProject];
    
    // Deselect the selected row.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.authorizationManager authorizeOperation:DELETE_PROJECT]) {
        return UITableViewCellEditingStyleDelete;
    } /* The currently signed-in user can delete projects. */
    return UITableViewCellEditingStyleNone;
}

#pragma mark - Project Data Source delegate

- (BOOL)isFiltering
{
    return [self.searchController isActive] && ![self.searchController.searchBar.text isEmpty];
}

- (void)onFetchCompleted
{
    NSUInteger projectsCount = [self.dataSource getProjectsCount];
    
    // Display a Message View, if applicable.
    if (projectsCount < 1)
    {
        [self.tableView displayMessage:NSLocalizedString(@"noProjectDescription", NULL) withTitle:NSLocalizedString(@"noProjectTitle", NULL)];
    } else {
        [self.tableView removeBackgroundView];
    }
    
    [self.tableView reloadData];
    [self.tableView setScrollEnabled:projectsCount > 0];
}

- (void)onFetchFailedWithError:(NSError *)error
{
    [self.tableView setScrollEnabled:NO];
    [self.tableView displayErrorViewWithMessage:error.localizedDescription];
}

- (void)onDeletionFailedWithError:(NSError *)error
{
    [self presentErrorAlertControllerWithMessage:error.localizedDescription];
}

- (void)onDeleteProjectAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"deleteProject", NULL) message:NSLocalizedString(@"deleteProjectDisclaimer", NULL) preferredStyle:UIAlertControllerStyleAlert];
    
    // Configure the alert controller...
    __weak ProjectListViewController * weakSelf = self;
    UIAlertAction * deleteAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"delete", NULL) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.dataSource deleteProjectAtIndexPath:indexPath];
    }];
    [alertController addAction:deleteAction];
    UIAlertAction * dismissAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", NULL) style:UIAlertActionStyleCancel handler:NULL];
    [alertController addAction:dismissAction];
    
    // Present the alert controller.
    [self presentViewController:alertController animated:YES completion:NULL];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:_showProjectDetailSegueIdentifier]) {
        Project * project = (Project *) sender;
        ProjectDetailViewController * projectDetailViewController = (ProjectDetailViewController *) segue.destinationViewController;
        
        // Initialize the Project Detail View Controller's properties.
        [projectDetailViewController setProject:project];
        [projectDetailViewController setAuthorizationManager:self.authorizationManager];
    }
}

@end
