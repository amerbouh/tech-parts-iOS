//
//  MessageView.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-10-17.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "MessageView.h"

@interface MessageView ()

@property (weak, nonatomic) IBOutlet UILabel * titleLabel;
@property (weak, nonatomic) IBOutlet UILabel * messageLabel;

@end

@implementation MessageView

#pragma mark - Initialization

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView * contentView = (MessageView *) [[NSBundle.mainBundle loadNibNamed:@"MessageView" owner:self options:0] firstObject];
        
        // Add the content view as a subview.
        [self addSubview:contentView];
        
        // Set the content view's frame.
        contentView.frame = self.bounds;
        
        // Set the labels' text.
        _titleLabel.text = title;
        _messageLabel.text = message;
    }
    return self;
}

#pragma mark - Methods

- (void)setTitle:(NSString *)title
{
    [self.titleLabel setText:title];
}

- (void)setMessage:(NSString *)message
{
    [self.messageLabel setText:message];
}

@end
