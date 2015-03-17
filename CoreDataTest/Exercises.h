//
//  Exercises.h
//  CoreDataTest
//
//  Created by Joe Cunningham on 03/02/2015.
//  Copyright (c) 2015 Joe Cunningham. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface Exercises : ViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *exercisesToAdd;
@property (strong, nonatomic) NSMutableArray *exercises;
@property (strong, nonatomic) NSString *exerciseString;

@property (weak, nonatomic) IBOutlet UITableView *tableViewExercises;

- (IBAction)reset:(id)sender;

-(void)fetchData;
-(void)addExercises;
@end
