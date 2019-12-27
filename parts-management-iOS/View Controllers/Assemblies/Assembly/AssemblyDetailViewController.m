//
//  AssemblyDetailViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-25.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "AssemblyDetailViewController.h"
#import "Assembly.h"
#import "CreateAssemblyTableViewController.h"
#import "AssemblyInformationTableViewController.h"

@interface AssemblyDetailViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

/** @brief Confgures the bar button items displayed by the View Controller's navigation bar. */
- (void)configureBarButtonItems;

/** @brief Configures the  segmented control's segments. */
- (void)configureSegmentedControl;

/** @brief Encapsulates the code to execute once the add bar button item is taped. */
- (void)addBarButtonItemTaped:(UIBarButtonItem *)sender;

/** @brief Encapsulates the code to execute once the edit bar button item is taped. */
- (void)editBarButtonItemTaped:(UIBarButtonItem *)sender;

@end

@implementation AssemblyDetailViewController

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self configureBarButtonItems];
    [self configureSegmentedControl];
    [self.navigationItem setPrompt:self.assembly.code];
}

#pragma mark - Methods

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

- (void)configureSegmentedControl
{
    [self.segmentedControl setTitle:NSLocalizedString(@"information", NULL) forSegmentAtIndex:0];
    [self.segmentedControl setTitle:NSLocalizedString(@"subassemblies", NULL) forSegmentAtIndex:1];
}

- (void)addBarButtonItemTaped:(UIBarButtonItem *)sender
{
    
}

- (void)editBarButtonItemTaped:(UIBarButtonItem *)sender
{
    UINavigationController * navigationController = (UINavigationController *) [[UIStoryboard storyboardWithName:@"ProjectDetail" bundle:NULL] instantiateViewControllerWithIdentifier:@"CreateAssemblyVCNavigationController"];
    
    // Get an instance of the Create Project View Controller.
    CreateAssemblyTableViewController * createAssemblyTableViewController = (CreateAssemblyTableViewController *) navigationController.visibleViewController;
    
    // Configure the Create Project View Controller.
    createAssemblyTableViewController.assembly = self.assembly;
    createAssemblyTableViewController.projectIdentifier = self.assembly.projectId;
    
    // Present the navigation controller.
    [self presentViewController:navigationController animated:YES completion:NULL];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowAssemblyInformationViewControllerEmbedSegue"]) {
        AssemblyInformationTableViewController * assemblyInformationTableViewController = (AssemblyInformationTableViewController *) segue.destinationViewController;
        assemblyInformationTableViewController.assembly = self.assembly;
    }
}

@end
