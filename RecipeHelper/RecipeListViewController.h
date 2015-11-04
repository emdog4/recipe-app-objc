//
//  RecipeListViewController.h
//  ReceipePro
//
//  Created by Emery Clark on 7/7/13.
//  Copyright (c) 2013 Emery Clark. All rights reserved.
//

@import UIKit;

@interface RecipeListViewController : UIViewController <UISplitViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate, UINavigationBarDelegate>

- (void)refreshDatasource;

@end
