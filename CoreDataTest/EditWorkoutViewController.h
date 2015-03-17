//
//  EditWorkoutViewController.h
//  CoreDataTest
//
//  Created by Joe Cunningham on 09/10/2014.
//  Copyright (c) 2014 Joe Cunningham. All rights reserved.
//

#import "ViewController.h"

@interface EditWorkoutViewController : ViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *exercisesTableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) NSString *workoutName;
@property (strong, nonatomic) NSMutableArray *exercisesArray;
@property (weak, nonatomic) IBOutlet UIButton *exerciseTableViewEditButton;
@property (strong, nonatomic) NSIndexPath *addExerciseCellIndexPath;
@property (strong, nonatomic) NSString *exerciseNameNew;
@property (strong, nonatomic) NSMutableArray *numberOfSets;
@property (strong, nonatomic) NSMutableArray *numberOfReps;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

- (IBAction)unwindToEditWorkout:(UIStoryboardSegue *)unwindSegue;
- (IBAction)unwindToEditWorkoutAndSave:(UIStoryboardSegue *)unwindSegue;
- (IBAction)toggleTableViewEdit:(id)sender;

-(void)fetchData;
-(void)addExercise:(NSString *)name numberOfSets:(NSNumber *)sets numberOfReps:(NSNumber *)reps;

@end
