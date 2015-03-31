//
//  ViewController.h
//  Manager_Employee
//
//  Created by Parth Dobariya on 31/03/15.
//  Copyright (c) 2015 Parth Dobariya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manager.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) IBOutlet UITextField *txtName;

@property(nonatomic,strong) IBOutlet UITableView *tblManager;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

