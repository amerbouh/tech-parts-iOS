//
//  CreateAssemblyTableViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-24.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "CreateAssemblyTableViewController.h"
#import "Assembly.h"
#import "Progress.h"
#import "NSString+Empty.h"
#import "AssemblyRepository.h"
#import "FIRAssemblyCreating.h"
#import "ProgressPickerViewDataSource.h"
#import "UIViewController+PresentErrorAlertController.h"

@interface CreateAssemblyTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel * nameTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField * nameLabel;

@property (weak, nonatomic) IBOutlet UILabel * codeTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField * codeLabel;

@property (weak, nonatomic) IBOutlet UILabel * progressTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel * progressLabel;
@property (weak, nonatomic) IBOutlet UIPickerView * progressPickerView;

@property (weak, nonatomic) IBOutlet UILabel * dueDateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel * dueDateLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker * datePicker;

@property (weak, nonatomic) IBOutlet UITextView * descriptionTextView;

@property BOOL isDatePickerRowExpanded;
@property BOOL isProgressPickerRowExpanded;

/** A FIRAssemblyCreating conforming object responsible for creating / updating Assembly instances on the database. */
@property (strong, nonatomic, nonnull) id <FIRAssemblyCreating> assemblyCreator;

/** A data source object used to provider the rows displayed by the progress picker view. */
@property (strong, nonatomic, nonnull) ProgressPickerViewDataSource * progressPickerDataSource;

@end

@implementation CreateAssemblyTableViewController

static NSInteger ASSEMBLY_PROGRESS_ROW = 2;
static NSInteger ASSEMBLY_DUE_DATE_ROW = 4;
static CGFloat DEFAULT_ROW_HEIGHT = (CGFloat) 50;
static CGFloat DEFAULT_PICKER_EXPANDED_STATE_HEIGHT = (CGFloat) 216;

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _assemblyCreator = [AssemblyRepository new];
        _progressPickerDataSource = [ProgressPickerViewDataSource new];
    }
    return self;
}

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self configureDueDateLabel];
    [self configureProgressLabel];
    [self resolveSaveButtonEnabled];
    [self configureProgressPickerView];
    [self configureTableViewTitleLabels];
    [self.navigationItem setTitle:NSLocalizedString(@"createAssembly", NULL)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Do any additional setup before the view appears.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resolveSaveButtonEnabled) name:UITextViewTextDidChangeNotification object:NULL];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resolveSaveButtonEnabled) name:UITextFieldTextDidChangeNotification object:NULL];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Do any additional setup before the view disappears.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Methods

- (void)updateTableView
{
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void)configureDueDateLabel
{
    NSDateFormatter * dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    
    // Set the text displayed by the due date label.
    [self.dueDateLabel setText:[dateFormatter stringFromDate:[NSDate new]]];
}

- (void)configureProgressLabel
{
    [self.progressLabel setText:NSLocalizedString(@"toDo", NULL)];
}

- (void)configureProgressPickerView
{
    [self.progressPickerView setDelegate:self];
    [self.progressPickerView setDataSource:self.progressPickerDataSource];
}

- (void)configureTableViewTitleLabels
{
    [self.codeTitleLabel setText:NSLocalizedString(@"assemblyCode", NULL)];
    [self.nameTitleLabel setText:NSLocalizedString(@"assemblyName", NULL)];
    [self.dueDateTitleLabel setText:NSLocalizedString(@"assemblyDueDate", NULL)];
    [self.progressTitleLabel setText:NSLocalizedString(@"assemblyProgress", NULL)];
}

- (void)resolveSaveButtonEnabled
{
    if ([self.nameLabel.text isEmpty] || [self.codeLabel.text isEmpty] || [self.descriptionTextView.text isEmpty]) {
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
    } else {
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    }
}

- (IBAction)saveButtonTaped:(UIBarButtonItem *)sender
{
    NSDate * currentDate = [NSDate new];
    Progress progress = progress_from_string([self.progressLabel.text UTF8String]);
    
    // Initialize an assembly instance.
    Assembly * assembly = [[Assembly alloc] initWithCode:self.codeLabel.text name:self.nameLabel.text progress:progress projectId:self.projectIdentifier shortDescription:self.descriptionTextView.text cost:[NSNumber numberWithInt:0] subassembliesCount:[NSNumber numberWithInt:0] designFileSize:NULL designFileDownloadURL:NULL dueDate:[self.datePicker date] timestamp:currentDate lastUpdateTimestamp:currentDate];
    
    // Create a weak reference to the View Controller to avoid strong reference cycles.
    __weak CreateAssemblyTableViewController * weakSelf = self;
    
    // Upload the created assembly to Firebase.
    [self.assemblyCreator createAssembly:assembly completionHandler:^(NSError * _Nullable error) {
        if (error == NULL) {
            [weakSelf dismissViewControllerAnimated:YES completion:NULL];
        } else {
            [weakSelf presentErrorAlertControllerWithMessage:error.localizedDescription];
        }
    }];
}

- (IBAction)cancelBarButtonItemTaped:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)dueDatePickerValueChanged:(UIDatePicker *)sender
{
    NSDateFormatter * dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    
    // Set the text displayed by the due date label.
    [self.dueDateLabel setText:[dateFormatter stringFromDate:sender.date]];
}

#pragma mark - Picker view delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray<NSString *> * rowTitles = @[NSLocalizedString(@"toDo", NULL), NSLocalizedString(@"inProgress", NULL), NSLocalizedString(@"completed", NULL)];
    return rowTitles[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString * selectedProgress = [self pickerView:pickerView titleForRow:row forComponent:component];
    [self.progressLabel setText:selectedProgress];
}

#pragma mark - Table view delegate

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 0) return NSLocalizedString(@"namingConventionsDisclaimer", NULL);
    else if (section == 1) return NSLocalizedString(@"allFieldsShouldBeFilled", NULL);
    return NULL;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView endEditing:YES];
    
    // Act according to the selected row.
    if (indexPath.row == ASSEMBLY_PROGRESS_ROW) {
        self.isProgressPickerRowExpanded = !self.isProgressPickerRowExpanded;
    } else if (indexPath.row == ASSEMBLY_DUE_DATE_ROW) {
        self.isDatePickerRowExpanded = !self.isDatePickerRowExpanded;
    }
    
    // Update the table view.
    [self updateTableView];
    
    // Deselect the selected row.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) return 200;
    if (indexPath.row == ASSEMBLY_PROGRESS_ROW + 1) return self.isProgressPickerRowExpanded ? DEFAULT_PICKER_EXPANDED_STATE_HEIGHT : 0;
    if (indexPath.row == ASSEMBLY_DUE_DATE_ROW + 1) return self.isDatePickerRowExpanded ? DEFAULT_PICKER_EXPANDED_STATE_HEIGHT : 0;
    
    return DEFAULT_ROW_HEIGHT;
}

@end
