//
//  AddExerciseViewController.h
//  CoreDataTest
//
//  Created by Joe Cunningham on 17/12/2014.
//  Copyright (c) 2014 Joe Cunningham. All rights reserved.
//

#import "ViewController.h"

@interface AddExerciseViewController : ViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *exercisesArray;
@property (weak, nonatomic) IBOutlet UITableView *exercisesTableView;
@property (strong, nonatomic) NSString *selectedExerciseName;


- (IBAction)unwindToAddExercise:(UIStoryboardSegue *)unwindSegue;

@end
