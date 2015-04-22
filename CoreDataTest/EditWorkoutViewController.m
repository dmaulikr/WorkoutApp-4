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
    _numberOfSets = [NSMutableArray array];
    _numberOfReps = [NSMutableArray array];
    [_saveButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    _exercisesTableView.allowsSelection = NO;
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
    
/*    if ([results count]) {
        [_exercisesArray addObject:@"No exercises"];
        //NSAlertView: No Exercises!
    }
 
 */

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

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context = [appDelegate managedObjectContext];

        NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"WorkoutHasExercise" inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDesc];
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(exerciseName = %@)", _exercisesArray[indexPath.row]];
        [request setPredicate:pred];
        
        NSError *error;
        NSArray *objects = [context executeFetchRequest:request error:&error];

        for (NSManagedObject *managedObject in objects) {
            [context deleteObject:managedObject];
        }
        
        NSError *deleteError = nil;
        if (![context save:&deleteError]) {
            NSLog(@"uh oh");
        }
        [_exercisesTableView beginUpdates];
        [_exercisesArray removeObjectAtIndex:indexPath.row];
        [_exercisesTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_exercisesTableView endUpdates];
        [self fetchData];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    static NSString *cellID = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = [_exercisesArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ x %@", _numberOfSets[indexPath.row], _numberOfReps[indexPath.row]];

    
    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Exercises:";
}

-(void)addExercise:(NSString *)name numberOfSets:(NSNumber *)sets numberOfReps:(NSNumber *)reps {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSError *error;
    NSManagedObject *newExercise;
    newExercise = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutHasExercise" inManagedObjectContext:context];
    [newExercise setValue:_workoutName forKey:@"workoutName"];
    [newExercise setValue:name forKey:@"exerciseName"];
    [newExercise setValue:sets forKey:@"sets"];
    [newExercise setValue:reps forKey:@"reps"];
    
    [context save:&error];
    
    [self fetchData];


}



#pragma mark - Navigation

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
        
        NSNumber *sets = [NSNumber numberWithInteger:[vc.setsTextField.text integerValue]];
        NSNumber *reps = [NSNumber numberWithInteger:[vc.repsTextField.text integerValue]];

        [self addExercise:vc.exerciseName numberOfSets:sets numberOfReps:reps];
        
    }

    [self fetchData];
}
@end

