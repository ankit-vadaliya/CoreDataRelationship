//
//  AddEmployee.m
//  Manager_Employee
//
//  Created by Parth Dobariya on 31/03/15.
//  Copyright (c) 2015 Parth Dobariya. All rights reserved.
//

#import "AddEmployee.h"

@interface AddEmployee ()

@end

@implementation AddEmployee

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lblManager.text = [self.manager valueForKey:@"name"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(IBAction)btnAddPressed:(id)sender
{
    if(![self.txtName.text isEqualToString:@""])
    {
        NSEntityDescription *managerEntityDescription = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:self.managedObjectContext];
        
        Employee *newEmployee = (Employee *)[[NSManagedObject alloc] initWithEntity:managerEntityDescription
                                                  insertIntoManagedObjectContext:self.managedObjectContext];
        
        newEmployee.name = self.txtName.text;
        
        [self.manager addEmployeeObject:newEmployee];
        
        NSError *error = nil;
        
        if (![[self managedObjectContext] save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        else
        {
            [self viewWillAppear:YES];
        }
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"Hey man you totally forgot to input some information!" delegate:nil cancelButtonTitle:@"Got It!" otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    self.txtName.text = @"";
    [self.tblEmployee reloadData];
    self.navigationController.navigationBarHidden=NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.txtName resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu=",(long)self.manager.employee.count);
    
    return self.manager.employee.count;
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
    
    Employee *employee = [self.manager.employee.allObjects objectAtIndex:indexPath.row];
    
    cell.textLabel.text = employee.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arrEmployee = [[NSMutableArray alloc] init];
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Employee"];
    arrEmployee = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    for(int i=0; i<[arrEmployee count]; i++)
    {
        NSLog(@"Employee:%d Name:%@",i,[[arrEmployee objectAtIndex:i] valueForKey:@"name"]);
    }
}

@end
