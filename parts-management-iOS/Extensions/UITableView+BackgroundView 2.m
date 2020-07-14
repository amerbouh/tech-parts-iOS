//
//  UITableView+BackgroundView.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-20.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "UITableView+BackgroundView.h"
#import "MessageView.h"

@implementation UITableView (BackgroundView)

- (void)removeBackgroundView
{
    [self setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self setBackgroundView:NULL];
}

- (void)displayErrorViewWithMessage:(NSString *)message
{
    MessageView * messageView = [[MessageView alloc] initWithTitle:NSLocalizedString(@"oops", NULL) message:message frame:self.bounds];
    
    // Remove the cells' separator view.
    [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Set the Message View as the table view's background view.
    [self setBackgroundView:messageView];
}

- (void)displayMessage:(NSString *)message withTitle:(NSString *)title
{
    MessageView * messageView = [[MessageView alloc] initWithTitle:title message:message frame:self.bounds];
    
    // Remove the cells' separator view.
    [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Set the Message View as the table view's background view.
    [self setBackgroundView:messageView];
}

@end
