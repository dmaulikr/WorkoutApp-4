//
//  SelectWorkoutViewController.h
//  CoreDataTest
//
//  Created by Joe Cunningham on 06/04/2015.
//  Copyright (c) 2015 Joe Cunningham. All rights reserved.
//

#import "ViewController.h"

@interface SelectWorkoutViewController : ViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *workoutsTableView;
@property (strong, nonatomic) NSMutableArray *workouts;
@property (strong, nonatomic) NSString *selectedWorkout;

@end
