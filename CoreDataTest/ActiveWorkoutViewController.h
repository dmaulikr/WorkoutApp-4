//
//  ActiveWorkoutViewController.h
//  CoreDataTest
//
//  Created by Joe Cunningham on 06/04/2015.
//  Copyright (c) 2015 Joe Cunningham. All rights reserved.
//

#import "ViewController.h"

@interface ActiveWorkoutViewController : ViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *exercisesTableView;
@property (strong, nonatomic) NSMutableArray *exercises;
@property (strong, nonatomic) NSMutableArray *totalSets;
@property (strong, nonatomic) NSString *workoutName;

@end
