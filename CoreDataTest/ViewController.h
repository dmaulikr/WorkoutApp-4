//
//  ViewController.h
//  CoreDataTest
//
//  Created by Joe Cunningham on 07/10/2014.
//  Copyright (c) 2014 Joe Cunningham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *workoutsArray;
@property (strong, nonatomic) NSIndexPath *deleteWorkoutIndexPath;
@property (strong, nonatomic) NSString *selectedWorkoutName;

//- (void)addWorkout:(NSString *)workoutName withNumberOfExercises:(NSNumber*)numberOfExercises;
- (void)addWorkout:(NSString *)workoutName;
- (void)fetchData;
- (IBAction)unwindToWorkoutList:(UIStoryboardSegue *)unwindSegue;
- (IBAction)unwindToWorkoutListAndSave:(UIStoryboardSegue *)unwindSegue;
//- (IBAction)saveWorkout:(UIStoryboardSegue *)unwindSegue;

@end

