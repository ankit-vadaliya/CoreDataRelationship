//
//  ManagersWithEmployees.m
//  Manager_Employee
//
//  Created by Parth Dobariya on 31/03/15.
//  Copyright (c) 2015 Parth Dobariya. All rights reserved.
//

#import "ManagersWithEmployees.h"
#import "Manager.h"
#import "Employee.h"

@interface ManagersWithEmployees ()

@end

@implementation ManagersWithEmployees

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Manager"];
    arrManager = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrManager count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    UILabel *lblManager = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
    lblManager.textAlignment=NSTextAlignmentCenter;
    lblManager.text=[[arrManager objectAtIndex:section] valueForKey:@"name"];
    [lblManager setBackgroundColor:[UIColor redColor]];
    [view addSubview:lblManager];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Manager *manager = [arrManager objectAtIndex:section];
    return manager.employee.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EmployeeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Manager *manager = [arrManager objectAtIndex:indexPath.section];
    
    Employee *employee = [manager.employee.allObjects objectAtIndex:indexPath.row];
    
    cell.textLabel.text = employee.name;
    
    return cell;
}

@end
