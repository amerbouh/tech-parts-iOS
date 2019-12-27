//
//  UIViewController+PresentErrorAlertController.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-21.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "UIViewController+PresentErrorAlertController.h"

@implementation UIViewController (PresentErrorAlertController)

- (void)presentErrorAlertControllerWithMessage:(NSString *)message
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"oops", NULL) message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Configure the alert controller...
    UIAlertAction * dismissAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:NULL];
    [alertController addAction:dismissAction];
    
    // Present the alert controller.
    [self presentViewController:alertController animated:YES completion:NULL];
}

@end
