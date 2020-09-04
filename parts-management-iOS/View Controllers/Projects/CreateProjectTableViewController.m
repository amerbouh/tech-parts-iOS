//
//  CreateProjectTableViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "CreateProjectTableViewController.h"
#import "Project.h"
#import "NSString+Empty.h"
#import "ProjectRepository.h"
#import "UIViewController+PresentErrorAlertController.h"

@interface CreateProjectTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField * projectNameTextField;
@property (weak, nonatomic) IBOutlet UITextField * robotNameTextField;
@property (weak, nonatomic) IBOutlet UITextField * challengeNameTextField;
@property (weak, nonatomic) IBOutlet UILabel * seasonLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker * seasonDatePicker;
@property (weak, nonatomic) IBOutlet UITableViewCell * seasonDatePickerTableViewCell;
@property (weak, nonatomic) IBOutlet UITextView * descriptionTextView;

@property BOOL isDatePickerRowExpanded;
@property (strong, nonatomic, nullable) Project * project;

@end

@implementation CreateProjectTableViewController

static CGFloat DEFAULT_ROW_HEIGHT = (CGFloat) 50;
static CGFloat DEFAULT_DATE_PICKER_EXPANDED_STATE_HEIGHT = (CGFloat) 216;

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _projectCreator = [ProjectRepository new];
    }
    return self;
}

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self configureSeasonLabel];
    [self resolveSaveButtonEnabled];
    [self configureNavigationItemTitle];
    [self configureDescriptionTextView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Do any additional setup before the view appears.
    [self populateViewsIfApplicable];
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

- (void)setEditedProject:(Project *)editedProject
{
    [self setProject:editedProject];
}

- (void)createProject
{
    NSDate * currentDate = [NSDate new];
    NSString * season = self.seasonLabel.text;
    NSString * robotName = self.robotNameTextField.text;
    NSString * projectName = self.projectNameTextField.text;
    NSString * challengeName = self.challengeNameTextField.text;
    NSString * description = self.descriptionTextView.text;
    NSNumber * cost = [NSNumber numberWithInt:0];
    NSNumber * assembliesCount = [NSNumber numberWithInt:0];
       
    // Create a configure a number formatter.
    NSNumberFormatter * numberFormatter = [NSNumberFormatter new];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
       
    // Initialize a Project instance with the given inputs.
    Project * project = [[Project alloc] initWithName:projectName cost:cost season:[numberFormatter numberFromString:season] assembliesCount:assembliesCount robotName:robotName authorName:@"Sylvain Gauvreau" shortDescription:description challengeName:challengeName timestamp:currentDate lastUpdateTimestamp:currentDate];
       
    // Create a weak reference to the View Controller to avoid strong reference cycles.
    __weak CreateProjectTableViewController * weakSelf = self;
       
    // Upload the created project to Firebase.
    [self.projectCreator createProject:project completionHandler:^(NSError * _Nullable error) {
        if (error == NULL) {
            [weakSelf dismissViewControllerAnimated:YES completion:NULL];
        } else {
            [weakSelf presentErrorAlertControllerWithMessage:error.localizedDescription];
        }
    }];
}

- (void)updateProject
{
    NSString * season = self.seasonLabel.text;
    NSString * robotName = self.robotNameTextField.text;
    NSString * projectName = self.projectNameTextField.text;
    NSString * challengeName = self.challengeNameTextField.text;
    NSString * description = self.descriptionTextView.text;
    
    // Create a configure a number formatter.
    NSNumberFormatter * numberFormatter = [NSNumberFormatter new];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    // Update the project instance.
    [self.project setSeason:[numberFormatter numberFromString:season]];
    [self.project setName:projectName];
    [self.project setRobotName:robotName];
    [self.project setChallengeName:challengeName];
    [self.project setShortDescription:description];
    [self.project setShortDescription:description];
    
    // Create a weak reference to the View Controller to avoid strong reference cycles.
    __weak CreateProjectTableViewController * weakSelf = self;
    
    // Push the updates to Firebase.
    [self.projectCreator updateProject:self.project completionHandler:^(NSError * _Nullable error) {
        if (error == NULL) {
            [weakSelf dismissViewControllerAnimated:YES completion:NULL];
        } else {
            [weakSelf presentErrorAlertControllerWithMessage:error.localizedDescription];
        }
    }];
}

- (void)configureSeasonLabel
{
    NSDateFormatter * dateFormatter = [NSDateFormatter new];
    
    // Configure the date formatter.
    [dateFormatter setDateFormat:@"yyyy"];
    
    // Convert the selected date to a string.
    NSString * dateString = [dateFormatter stringFromDate:self.seasonDatePicker.date];
    
    // Update the text displayed by the season label.
    [self.seasonLabel setText:dateString];
}

- (void)configureNavigationItemTitle
{
    if (self.project == NULL) {
        [self.navigationItem setTitle:NSLocalizedString(@"createProject", NULL)];
    } else {
        [self.navigationItem setTitle:NSLocalizedString(@"editProject", NULL)];
    }
}

- (void)configureDescriptionTextView
{
     NSDateFormatter * dateFormatter = [NSDateFormatter new];
       
    // Configure the date formatter.
    [dateFormatter setDateFormat:@"yyyy"];
       
    // Convert the selected date to a string.
    NSString * dateString = [dateFormatter stringFromDate:self.seasonDatePicker.date];
    
    // Set the text view's text.
    NSString * textViewContent = [NSString stringWithFormat: NSLocalizedString(@"projectDescription", NULL), dateString];
    [self.descriptionTextView setText:textViewContent];
}

- (void)populateViewsIfApplicable
{
    if (self.project == NULL) return;
    
    // Get an NSDateFormatter instance and configure it.
    NSDateFormatter * dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy"];
    
    // Get an NSNumberFormatter instance and create a string representing the project's
    // season.
    NSNumberFormatter * numberFormatter = [NSNumberFormatter new];
    NSString * seasonString = [numberFormatter stringFromNumber:self.project.season];
    
    // Populate the views with the project's data.
    [self.projectNameTextField setText:self.project.name];
    [self.robotNameTextField setText:self.project.robotName];
    [self.challengeNameTextField setText:self.project.challengeName];
    [self.seasonLabel setText:seasonString];
    [self.seasonDatePicker setDate:[dateFormatter dateFromString:seasonString]];
    [self.descriptionTextView setText:self.project.shortDescription];
}

- (void)resolveSaveButtonEnabled
{
    if ([self.projectNameTextField.text isEmpty] || [self.robotNameTextField.text isEmpty] || [self.challengeNameTextField.text isEmpty] || [self.descriptionTextView.text isEmpty]) {
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
    } else {
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    }
}

- (IBAction)saveBarButtonTaped:(UIBarButtonItem *)sender
{
    if (self.project == NULL) {
        [self createProject];
    } else {
        [self updateProject];
    }
}

- (IBAction)cancelBarButtonTaped:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)seasonDatePickerValueChanged:(UIDatePicker *)sender
{
    [self configureSeasonLabel];
    [self resolveSaveButtonEnabled];
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
    if (indexPath.row == 3) {
        [self.tableView endEditing:YES];
        
        // Update the isDatePickerRowExpanded accordingly.
        self.isDatePickerRowExpanded = !self.isDatePickerRowExpanded;
        
        // Update the table view.
        [tableView beginUpdates];
        [tableView endUpdates];
    }
  
    // Deselect the selected row.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) return 200;
    if (indexPath.row != 4) return DEFAULT_ROW_HEIGHT;
    
    // Return the appropriate size for the Date Picker Row.
    if (self.isDatePickerRowExpanded) return DEFAULT_DATE_PICKER_EXPANDED_STATE_HEIGHT;
    else return 0;
}

@end
