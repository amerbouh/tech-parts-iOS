//
//  SignUpViewController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-30.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UILabel * titleLabel;
@property (weak, nonatomic) IBOutlet UILabel * subtitleLabel;

@end

@implementation SignUpViewController

#pragma mark - View's lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

#pragma mark - Methods

- (IBAction)cancelBarButtonItemTaped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
