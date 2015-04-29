//
//  ViewController.m
//  CoreDataTest
//
//  Created by Joe Cunningham on 07/10/2014.
//  Copyright (c) 2014 Joe Cunningham. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "AddWorkoutViewController.h"
#import "EditWorkoutViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _workoutsArray = [NSMutableArray array];
    [self fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    _selectedWorkoutName = selectedCell.textLabel.text;
    [self performSegueWithIdentifier:@"editWorkoutSegue" sender:self];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        
        NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDesc];
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name = %@)", _workoutsArray[indexPath.row]];
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
        [_tableView beginUpdates];
        [_workoutsArray removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_tableView endUpdates];
        [self fetchData];
        
    }
}

/*
 -(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 _deleteWorkoutIndexPath = indexPath;
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete workout" message:@"Are you sure you want to delete the workout?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
 
 [alert show];
 
 }
 
 }
 
 -(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
 if (buttonIndex == 0) {
 AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
 
 NSManagedObjectContext *context = [appDelegate managedObjectContext];
 
 NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
 NSFetchRequest *request = [[NSFetchRequest alloc] init];
 [request setEntity:entityDesc];
 
 NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name = %@)", _workoutsArray[_deleteWorkoutIndexPath.row]];
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
 [_tableView beginUpdates];
 [_workoutsArray removeObjectAtIndex:_deleteWorkoutIndexPath.row];
 [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:_deleteWorkoutIndexPath] withRowAnimation:UITableViewRowAnimationFade];
 [_tableView endUpdates];
 [self fetchData];
 
 } else {
 
 }
 
 }
 */

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_workoutsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = [_workoutsArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)fetchData {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    //NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name = %@)", _workoutToAdd];
    //[request setPredicate:pred];
    
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] == 0) {
        //       NSLog(@"No matches");
    } else {
        [_workoutsArray removeAllObjects];
        for (int x = 0; x < [objects count]; x++) {
            matches = objects[x];
            if ([matches valueForKey:@"name"]) {
                [_workoutsArray addObject:[matches valueForKey:@"name"]];
            }
        }
        [_tableView reloadData];
        //   NSLog(@"%lu matches found", (unsigned long)[objects count]);
    }
    
}

-(void)addWorkout:(NSString *)workoutName {
    NSString *trimmedString = [workoutName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (![trimmedString isEqualToString:@""]) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        
        NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDesc];
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name = %@)", trimmedString];
        [request setPredicate:pred];
        
        NSError *error;
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        if (![objects count]) {
            NSManagedObject *newWorkout;
            newWorkout = [NSEntityDescription insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:context];
            //  [newWorkout]
            [newWorkout setValue:trimmedString forKey:@"name"];
            NSError *error;
            
            [context save:&error];
            //   NSLog(@"Contact saved");
            
            [self fetchData];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"A workout with that name already exists" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"You didn't enter a workout name!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"editWorkoutSegue"]) {
        EditWorkoutViewController *vc = [segue destinationViewController];
        vc.workoutName = _selectedWorkoutName;
    }
}
/*
 -(IBAction)saveWorkout:(UIStoryboardSegue *)unwindSegue {
 //Grab the exercise names and numbers of sets/reps from EditWorkoutViewController
 //Then save them to CoreData
 EditWorkoutViewController *vc = [unwindSegue sourceViewController];
 
 if ([vc.exercisesArray count] != 0) {
 AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
 
 NSManagedObjectContext *context = [appDelegate managedObjectContext];
 
 
 //DELETE all entries with workout name = _selectedWorkoutName before adding the new ones
 //For x = 1 to [vc.exercisesArray count]
 //add exercise
 //Fetch
 NSError *error;
 NSManagedObject *newWorkout;
 for (int x = 0; x < [vc.exercisesArray count]; x++) {
 newWorkout = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutHasExercise" inManagedObjectContext:context];
 [newWorkout setValue:_selectedWorkoutName forKey:@"workoutName"];
 [newWorkout setValue:vc.exercisesArray[x] forKey:@"exerciseName"];
 [newWorkout setValue:vc.numberOfSets[x] forKey:@"sets"];
 [newWorkout setValue:vc.numberOfReps[x] forKey:@"reps"];
 }
 [context save:&error];
 
 [self fetchData];
 } else {
 NSLog(@"No exercises!");
 //Alert
 }
 
 
 [_tableView reloadData];
 } */

-(void)unwindToWorkoutList:(UIStoryboardSegue *)unwindSegue {
    [_tableView reloadData];
}

-(IBAction)unwindToWorkoutListAndSave:(UIStoryboardSegue *)unwindSegue {
    UIViewController* sourceViewController = unwindSegue.sourceViewController;
    
    if ([sourceViewController isKindOfClass:[AddWorkoutViewController class]]) {
        
        AddWorkoutViewController *vc = [unwindSegue sourceViewController];
        
        [self addWorkout:vc.workoutNameTextField.text];
    }
    [_tableView reloadData];
}
@end
