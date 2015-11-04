//
//  IngredientDetailViewController.m
//  RecipeHelper
//
//  Created by Emery Clark on 9/21/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import "IngredientDetailViewController.h"
#import "TextFieldTableViewCell.h"

@interface IngredientDetailViewController ()

@end

@implementation IngredientDetailViewController

- (instancetype)init
{
    if (self= [super init])
    {
        self.view = [[UIView alloc] init];
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        self.title = @"Details";
        
        _navBar = [[UINavigationBar alloc] init];
        _navBar.translatesAutoresizingMaskIntoConstraints = NO;
        
        _navItem = [[UINavigationItem alloc] init];
        _navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(random:)];
        _navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(random:)];
        
        [_navBar pushNavigationItem:_navItem animated:YES];
        
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
        _textField.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addSubview:_navBar];
        [self.view addSubview:_textField];
        [self.view addSubview:_pickerView];
        
        id _topLayoutGuide = self.topLayoutGuide;
        
        NSMutableArray *constraints = [NSMutableArray array];
        NSDictionary *_bindings = NSDictionaryOfVariableBindings(_textField, _pickerView, _navBar, _topLayoutGuide);
        
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_topLayoutGuide][_navBar][_textField][_pickerView]|" options:0 metrics:nil views:_bindings]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_navBar]|" options:0 metrics:nil views:_bindings]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_textField]|" options:0 metrics:nil views:_bindings]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_pickerView]|" options:0 metrics:nil views:_bindings]];
        
        [self.view addConstraints:constraints];
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}


-(void)random:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
