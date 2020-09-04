//
//  AssemblyListViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-22.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "AssemblyListViewController.h"
#import "NSString+Empty.h"
#import "AssemblyDataSource.h"
#import "AssemblyRepository.h"
#import "AssemblyTableViewCell.h"
#import "AssemblyDetailViewController.h"
#import "CreateAssemblyTableViewController.h"
#import "UITableView+BackgroundView.h"
#import "UIViewController+PresentErrorAlertController.h"

@interface AssemblyListViewController ()

/**
 The UISearchBar instance used to allow the user to filter the assemblies dipslayed by the table
 view.
 */
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

/** The UITableView instance used to display a list of assemblies to the user. */
@property (weak, nonatomic) IBOutlet UITableView * tableView;

/** The data source object used by the Table View instance to display a list of assemblies. */
@property (strong, nonatomic, nonnull) AssemblyDataSource * dataSource;

@end

@implementation AssemblyListViewController

static NSString * const _cellReuseIdentifier = @"AssemblyTableViewCell";
static NSString * const _showAssemblyDetailViewControllerSegueIdentifier = @"ShowAssemblyDetailViewControllerSegue";
static NSString * const _showCreateAssemblyTableViewControllerSegueIdentifier = @"ShowCreateAssemblyTableViewControllerSegue";

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        AssemblyRepository * assemblyRepository = [AssemblyRepository new];
        _dataSource = [[AssemblyDataSource alloc] initWithAssemblyFetcher:assemblyRepository assemblyDeleter:assemblyRepository cellReuseIdentifier:_cellReuseIdentifier];
        _dataSource.delegate = self;
    }
    return self;
}

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Register cell classes...
    [self.tableView registerClass:[AssemblyTableViewCell class] forCellReuseIdentifier:_cellReuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self configureTableView];
    [self configureSearchBar];
    [self.dataSource loadAssembliesForProjectWithIdentifier:self.projectIdentifier];
}

#pragma mark - Methods

- (void)configureTableView
{
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self.dataSource];
}

- (void)configureSearchBar
{
    [self.searchBar setDelegate:self];
    [self.searchBar setPlaceholder:NSLocalizedString(@"searchAssembly", NULL)];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar setText:NULL];
    [searchBar resignFirstResponder];
    [self.tableView reloadData];
}

#pragma mark - Project detail view controller delegate

- (void)projectDetailViewController:(id)projectDetailViewController didTapRightBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self performSegueWithIdentifier:_showCreateAssemblyTableViewControllerSegueIdentifier sender:barButtonItem];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchBar resignFirstResponder];
    
    // Get the selected assembly.
    Assembly * selectedAssembly = [self.dataSource getAssemblyAtIndexPath:indexPath];
    
    // Display the Assembly Detail View Controller.
    [self performSegueWithIdentifier:_showAssemblyDetailViewControllerSegueIdentifier sender:selectedAssembly];
    
    // Deselect the selected row.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Search bar delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.dataSource filterAssembliesUsingPredicate:searchText];
    [self.tableView reloadData];
}

#pragma mark - Assembly Data Source delegate

- (BOOL)isFiltering
{
    return [self.searchBar isFirstResponder] && ![self.searchBar.text isEmpty];
}

- (void)onFetchCompleted
{
    NSUInteger assembliesCount = [self.dataSource getAssembliesCount];
        
    // Display a Message View, if applicable.
    if (assembliesCount < 1)
    {
        [self.tableView displayMessage:NSLocalizedString(@"noAssemblyDescription", NULL) withTitle:NSLocalizedString(@"noAssemblyTitle", NULL)];
    } else {
        [self.tableView removeBackgroundView];
    }
    
    [self.tableView reloadData];
    [self.tableView setScrollEnabled:assembliesCount > 0];
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

- (void)onDeleteAssemblyAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"deleteAssembly", NULL) message:NSLocalizedString(@"deleteAssemblyDisclaimer", NULL) preferredStyle:UIAlertControllerStyleAlert];
    
    // Configure the alert controller...
    __weak AssemblyListViewController * weakSelf = self;
    UIAlertAction * deleteAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"delete", NULL) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.dataSource deleteAssemblyAtIndexPath:indexPath];
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
    if ([segue.identifier isEqualToString:_showCreateAssemblyTableViewControllerSegueIdentifier]) {
        UINavigationController * navigationController = (UINavigationController *) segue.destinationViewController;
        CreateAssemblyTableViewController * createAssemblyTableViewController = (CreateAssemblyTableViewController *) navigationController.visibleViewController;
        createAssemblyTableViewController.projectIdentifier = self.projectIdentifier;
    } else if ([segue.identifier isEqualToString:_showAssemblyDetailViewControllerSegueIdentifier]) {
        AssemblyDetailViewController * assemblyDetailViewController = (AssemblyDetailViewController *) segue.destinationViewController;
        assemblyDetailViewController.assembly = (Assembly *) sender;
    }
}

@end
