//
//  ProjectDetailViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-16.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "ProjectDetailViewController.h"
#import "Project.h"
#import "AssemblyListViewController.h"
#import "CreateProjectTableViewController.h"
#import "ProjectDetailViewControllerDelegate.h"
#import "ProjectInformationTableViewController.h"

@interface ProjectDetailViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl * segmentedControl;
@property (weak, nonatomic) IBOutlet UIView * assemblyListViewControllerContainerView;
@property (weak, nonatomic) IBOutlet UIView * projectInformationTableViewControllerContainerView;

/** The ProjectDetailViewControllerDelegate instance the View Controller uses to communicate events. */
@property (weak, nonatomic, nullable) id <ProjectDetailViewControllerDelegate> delegate;

/** @brief Confgures the container view displayed by the View Controller. */
- (void)configureContainerView;

/** @brief Confgures the bar button items displayed by the View Controller's navigation bar. */
- (void)configureBarButtonItems;

/** @brief Confgures the segmented control displayed by the View Controller. */
- (void)configureSegmentedControl;

/** @brief Encapsulates the code to execute once the add bar button item is taped. */
- (void)addBarButtonItemTaped:(UIBarButtonItem *)sender;

/** @brief Encapsulates the code to execute once the edit bar button item is taped. */
- (void)editBarButtonItemTaped:(UIBarButtonItem *)sender;

@end

@implementation ProjectDetailViewController

static NSString * _assemblyListEmbedSegueIdentifier = @"AssemblyListEmbedSegue";
static NSString * _projectInformationEmbedSegueIdentifier = @"ProjectInformationEmbedSegue";

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self configureContainerView];
    [self configureBarButtonItems];
    [self configureSegmentedControl];
    [self.navigationItem setPrompt:self.project.name];
}

#pragma mark - Methods

- (void)configureContainerView
{
    [self.assemblyListViewControllerContainerView setAlpha:0];
}

- (void)configureSegmentedControl
{
    [self.segmentedControl setTitle:NSLocalizedString(@"information", NULL) forSegmentAtIndex:0];
    [self.segmentedControl setTitle:NSLocalizedString(@"assemblies", NULL) forSegmentAtIndex:1];
}

- (void)configureBarButtonItems
{
    [self.navigationItem setRightBarButtonItem:NULL];
    
    // Configure the bar button items according to selected segmented control index.
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        UIBarButtonItem * editBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editBarButtonItemTaped:)];
        [self.navigationItem setRightBarButtonItem:editBarButtonItem];
    } else {
        UIBarButtonItem * addBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBarButtonItemTaped:)];
        [self.navigationItem setRightBarButtonItem:addBarButtonItem];
    }
}

- (void)editBarButtonItemTaped:(UIBarButtonItem *)sender
{
    UINavigationController * navigationController = (UINavigationController *) [[UIStoryboard storyboardWithName:@"Project" bundle:NULL] instantiateViewControllerWithIdentifier:@"CreateProjectVCNavigationController"];
    
    // Get an instance of the Create Project View Controller.
    CreateProjectTableViewController * createProjectTableViewController = (CreateProjectTableViewController *) navigationController.visibleViewController;
    [createProjectTableViewController setEditedProject:self.project];
    
    // Present the navigation controller.
    [self presentViewController:navigationController animated:YES completion:NULL];
}

- (void)addBarButtonItemTaped:(UIBarButtonItem *)sender
{
    [self.delegate projectDetailViewController:self didTapRightBarButtonItem:sender];
}

- (IBAction)segmentedControlValueDidChange:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self.assemblyListViewControllerContainerView setAlpha:0];
        [self.assemblyListViewControllerContainerView endEditing:YES];
        [self.projectInformationTableViewControllerContainerView setAlpha:1];
    } else {
        [self.projectInformationTableViewControllerContainerView setAlpha:0];
        [self.assemblyListViewControllerContainerView setAlpha:1];
    }
    
    // Update the right bar button items.
    [self configureBarButtonItems];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:_projectInformationEmbedSegueIdentifier]) {
        ProjectInformationTableViewController * projectInformationTableViewController = (ProjectInformationTableViewController *) segue.destinationViewController;
        projectInformationTableViewController.project = self.project;
    } else if ([segue.identifier isEqualToString:_assemblyListEmbedSegueIdentifier]) {
        AssemblyListViewController * assemblyListViewController = (AssemblyListViewController *) segue.destinationViewController;
        assemblyListViewController.projectIdentifier = self.project.identifier;
        
        // Affect the delegate property.
        self.delegate = segue.destinationViewController;
    }
}

@end
