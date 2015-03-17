//
//  EditWorkoutViewController.m
//  CoreDataTest
//
//  Created by Joe Cunningham on 09/10/2014.
//  Copyright (c) 2014 Joe Cunningham. All rights reserved.
//

#import "EditWorkoutViewController.h"
#import "AddExerciseViewController.h"
#import "AddExerciseDetailsViewController.h"
#import "AppDelegate.h"

@interface EditWorkoutViewController ()

@end

@implementation EditWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleLabel.text = _workoutName;
    _exercisesTableView.scrollEnabled = YES;
    _exercisesArray = [NSMutableArray array];
  //  [_dataSourceArray addObject:@"Add new exercise..."];
  //  _exercisesTableView.backgroundView = nil;
    _numberOfSets = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], nil];
    _numberOfReps = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:1], nil];
    [self fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
///*
-(void)fetchData {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"WorkoutHasExercise" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    request.resultType = NSDictionaryResultType;
    request.propertiesToFetch = [NSArray arrayWithObjects:@"exerciseName", @"reps", @"sets", nil];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(workoutName = %@)", _workoutName];
    [request setPredicate:pred];
    
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    [_exercisesArray removeAllObjects];
    [_numberOfSets removeAllObjects];
    [_numberOfReps removeAllObjects];
    
    for (int x = 0; x < [results count]; x++) {
        matches = results[x];
        [_exercisesArray addObject:[matches valueForKey:@"exerciseName"]];
        [_numberOfSets addObject:[matches valueForKey:@"sets"]];
        [_numberOfReps addObject:[matches valueForKey:@"reps"]];
    }

    [_exercisesTableView reloadData];
    
    
    
/*    if ([objects count] == 0) {
        //       NSLog(@"No matches");
    } else {
        [_workoutsArray removeAllObjects];
        for (int x = 0; x < [objects count]; x++) {
            matches = objects[x];
            [_workoutsArray addObject:[matches valueForKey:@"name"]];
        }
        [_tableView reloadData];
        //   NSLog(@"%lu matches found", (unsigned long)[objects count]);
    }
    
    
    [_dataSourceArray removeAllObjects];
    
    
    if ([objects count] != 0) {
        
        for (int x = 0; x < [objects count]; x++) {
            matches = objects[x];
            [_dataSourceArray addObject:[matches valueForKey:@"name"]];
        }
    }
    
    
    [_exercisesTableView reloadData];
    */

    
}// */

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_exercisesArray count];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
/*    if (indexPath == _addExerciseCellIndexPath) {
        [self performSegueWithIdentifier:@"addExerciseSegue" sender:self];
    }*/
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    static NSString *cellID = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = [_exercisesArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ x %@", _numberOfSets[indexPath.row], _numberOfReps[indexPath.row]];

/*     if (indexPath.row == indexPath.length) {
         cell.detailTextLabel.text = @"";
         _addExerciseCellIndexPath = indexPath;
     } */
    
    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Exercises:";
}

/*-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1.0f;
}*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)unwindToEditWorkout:(UIStoryboardSegue *)unwindSegue {
    [_exercisesTableView reloadData];
}

-(void)unwindToEditWorkoutAndSave:(UIStoryboardSegue *)unwindSegue {
    //Find the sender view controller
    //Add the new exercise or
    //Save the changes to existing exercise
    
    UIViewController* sourceViewController = unwindSegue.sourceViewController;
    
    if ([sourceViewController isKindOfClass:[AddExerciseDetailsViewController class]]) { //If the sender was Add Exercise
        
        AddExerciseDetailsViewController *vc = [unwindSegue sourceViewController];
        _exerciseNameNew = vc.exerciseName;
        _numberOfSets[[_exercisesArray count]] = [NSNumber numberWithInteger:[vc.setsTextField.text integerValue]];
        _numberOfReps[[_exercisesArray count]] = [NSNumber numberWithInteger:[vc.repsTextField.text integerValue]];
      //  [_dataSourceArray addObject:_exerciseNameNew];
        NSUInteger index = [_exercisesArray count] - 1;
        [_exercisesArray addObject:_exerciseNameNew];
        //array for number of sets and reps, get indexpath.row or something
    }

    [self fetchData];
}


@end

