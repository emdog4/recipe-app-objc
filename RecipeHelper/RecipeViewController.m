//
//  RECRecipeViewController.m
//  RecipeHelper
//
//  Created by Emery Clark on 9/18/13.
//  Copyright (c) 2013 Emery Clark. All rights reserved.
//

#import "RecipeViewController.h"
#import "PickerCell.h"
#import "PrepTimes.h"

@interface RecipeViewController ()

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end


@implementation RecipeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[PickerCell class] forCellReuseIdentifier:@"PickerCell"];
    
}

#pragma mark - Table View datasource & delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    
    if (section == 0) {
        rows = 1;
    }
    
    if (section == 1) {
        rows = 3;
        
        if (self.selectedIndexPath) {
            rows++;
        }
    }
    
    if (section == 2) {
        rows = 2;
    }
    
    return rows;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    
    if (section == 0) {
        title = @"Recipe";
    }
    
    if (section == 1) {
        title = @"General Info";
    }
    
    if (section == 2) {
        title = @"Misc";
    }
    
    return title;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *RecipeCellId = @"RecipeCell";
    static NSString *InfoCellId = @"InfoCell";
    static NSString *MiscCellId = @"MiscCell";
    static NSString *PickerCellId = @"PickerCell";
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSIndexPath *pickerCellIndexPath = [NSIndexPath indexPathForRow:(self.selectedIndexPath.row+1) inSection:self.selectedIndexPath.section];
    
    UITableViewCell *cell = nil;
    
    if (![indexPath isEqual:pickerCellIndexPath])
    {
        if (section == 0)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:RecipeCellId forIndexPath:indexPath];
        }
        
        if (section == 1)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:InfoCellId forIndexPath:indexPath];
            
            //we always return a cell for row=0
            if (row == 0)
            {
                cell.textLabel.text = @"Preparation Time";
                
                cell.detailTextLabel.text = @"< 45 min.";
            }
            else
            {
                if (self.selectedIndexPath)
                {
                    NSUInteger pickerRow = self.selectedIndexPath.row + 1;
                    
                    //user has SELECTED row=0
                    //return cells for rows 2 and 3
                    //row 1 will be a picker cell
                    if (pickerRow == 1)
                    {
                        if (row == 2)
                        {
                            cell.textLabel.text = @"Difficulty";
                            
                            cell.detailTextLabel.text = @"Medium";
                        }
                        
                        if (row == 3)
                        {
                            cell.textLabel.text = @"Category";
                            
                            cell.detailTextLabel.text = @"Favorite";
                        }
                    }
                    else if (pickerRow == 2)
                    {
                        if (row == 1)
                        {
                            cell.textLabel.text = @"Difficulty";
                            
                            cell.detailTextLabel.text = @"Medium";
                        }
                        
                        if (row == 3)
                        {
                            cell.textLabel.text = @"Category";
                            
                            cell.detailTextLabel.text = @"Favorite";
                        }
                    }
                    else if (pickerRow == 3)
                    {
                        if (row == 1)
                        {
                            cell.textLabel.text = @"Difficulty";
                            
                            cell.detailTextLabel.text = @"Medium";
                        }
                        
                        if (row == 2)
                        {
                            cell.textLabel.text = @"Category";
                            
                            cell.detailTextLabel.text = @"Favorite";
                        }
                    }
                }
                else
                {
                    //user hasn't selected a row so we return the defaults
                    if (row == 1)
                    {
                        cell.textLabel.text = @"Difficulty";
                        
                        cell.detailTextLabel.text = @"Medium";
                    }
                    
                    if (row == 2)
                    {
                        cell.textLabel.text = @"Category";
                        
                        cell.detailTextLabel.text = @"Favorite";
                    }
                }
            }
        }
        
        if (section == 2)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:MiscCellId forIndexPath:indexPath];
            
            if (row == 0)
            {
                cell.textLabel.text = @"Notes";
            }
            
            if (row == 1)
            {
                cell.textLabel.text = @"Share";
            }
        }
    }
    else
    {
        //All picker cells
        PickerCell *pickerCell = [tableView dequeueReusableCellWithIdentifier:PickerCellId forIndexPath:indexPath];
        pickerCell.pickerView.tag = self.selectedIndexPath.row;
        pickerCell.pickerView.dataSource = self;
        pickerCell.pickerView.delegate = self;
        return pickerCell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self cellIsSelected:indexPath] && indexPath.section == 1)
    {
        self.selectedIndexPath = nil;
        
        [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:(indexPath.row+1) inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        self.selectedIndexPath = indexPath;
        
        [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:(indexPath.row+1) inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger defaultRowHeight = 44.0;
    
    NSIndexPath *pickerCellIndexPath = [NSIndexPath indexPathForRow:(self.selectedIndexPath.row+1) inSection:self.selectedIndexPath.section];
    
    if ([indexPath isEqual:pickerCellIndexPath] && indexPath.section == 1)
    {
        defaultRowHeight = 162.0;
    }
    
    return defaultRowHeight;
}

#pragma mark - Text Field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    
    return YES;
}


#pragma mark - Picker View datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSUInteger tag = pickerView.tag;
    NSUInteger rowsInComponent = 0;
    
    switch (tag)
    {
        case 0:
            rowsInComponent = [[[PlistModel singleton] prepTimes] count];
            break;
            
        case 1:
            rowsInComponent = [[[PlistModel singleton] difficulties] count];
            break;
            
        case 2:
            rowsInComponent = [[[PlistModel singleton] categories] count];
            break;
            
        default:
            break;
    }
    
    return rowsInComponent;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSUInteger tag = pickerView.tag;
    NSString *string;
    
    switch (tag) {
        case 0:
            string = [[PlistModel singleton] prepTimeForIndex:row];
            break;
            
        case 1:
            string = [[PlistModel singleton] difficultyForIndex:row];
            break;
            
        case 2:
            string = [[PlistModel singleton] categoryForIndex:row];
            break;
            
        default:
            break;
    }
    
    return string;
}

#pragma mark - Private methods

- (BOOL)cellIsSelected:(NSIndexPath *)indexPath
{
    BOOL value = [indexPath isEqual:self.selectedIndexPath];
    
    //NSLog(@"Cell is Selected: %@", value ? @"YES" : @"NO");
    
    return value;
}


- (IBAction)doneButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)cancelButtonPressed:(UIButton *)sender {
        [self dismissViewControllerAnimated:YES completion:nil];
}

@end
