//
//  ManagersWithEmployees.h
//  Manager_Employee
//
//  Created by Parth Dobariya on 31/03/15.
//  Copyright (c) 2015 Parth Dobariya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagersWithEmployees : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *arrManager;
}
@property (nonatomic,strong) IBOutlet UITableView *tblView;

@end
