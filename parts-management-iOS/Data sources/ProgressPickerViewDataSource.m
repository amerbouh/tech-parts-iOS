//
//  ProgressPickerViewDataSource.m
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-24.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#import "ProgressPickerViewDataSource.h"

@implementation ProgressPickerViewDataSource

#pragma mark - Picker View data source

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 3;
}

@end
