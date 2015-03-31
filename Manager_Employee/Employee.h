//
//  Employee.h
//  Manager_Employee
//
//  Created by Parth Dobariya on 31/03/15.
//  Copyright (c) 2015 Parth Dobariya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Employee : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *manager;

@end
