//
//  AddEmployee.h
//  Manager_Employee
//
//  Created by Parth Dobariya on 31/03/15.
//  Copyright (c) 2015 Parth Dobariya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manager.h"
#import "Employee.h"

@interface AddEmployee : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) IBOutlet UITextField *txtName;

@property(nonatomic,strong) IBOutlet UITableView *tblEmployee;

@property(nonatomic,strong) IBOutlet UILabel *lblManager;

@property(nonatomic,strong) Manager *manager;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
