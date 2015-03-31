//
//  ViewController.m
//  Manager_Employee
//
//  Created by Parth Dobariya on 31/03/15.
//  Copyright (c) 2015 Parth Dobariya. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "AddEmployee.h"
#import "ManagersWithEmployees.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tblManager,txtName;

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
    NSEntityDescription *managerEntityDescription = [NSEntityDescription entityForName:@"Manager" inManagedObjectContext:self.managedObjectContext];
    
    Manager *newManager = (Manager *)[[NSManagedObject alloc] initWithEntity:managerEntityDescription
                                              insertIntoManagedObjectContext:self.managedObjectContext];
    
    newManager.name = self.txtName.text;
        
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.txtName.text = @"";
    self.navigationController.navigationBarHidden=YES;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Manager"];
    NSString *cacheName = @"ManagerCache";
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:nil cacheName:cacheName];
    NSError *error;
    if(![self.fetchedResultsController performFetch:&error])
    {
        NSLog(@"Fetch Failure: %@",error);
    }
    [self.tblManager reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    // Return the number of rows in the section.
    return self.fetchedResultsController.fetchedObjects.count;
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
    
    Manager *manager = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = manager.name;
    
    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddEmployee *emp = [self.storyboard instantiateViewControllerWithIdentifier:@"AddEmployee"];
    
    emp.manager = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [[self navigationController] pushViewController:emp animated:YES];
    
}

-(IBAction)AllManagerAndEmployee:(id)sender
{
    ManagersWithEmployees *me = [self.storyboard instantiateViewControllerWithIdentifier:@"ManagersWithEmployees"];
    [[self navigationController] pushViewController:me animated:YES];
}

@end
