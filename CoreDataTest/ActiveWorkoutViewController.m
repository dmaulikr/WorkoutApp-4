//
//  ActiveWorkoutViewController.m
//  CoreDataTest
//
//  Created by Joe Cunningham on 06/04/2015.
//  Copyright (c) 2015 Joe Cunningham. All rights reserved.
//

#import "ActiveWorkoutViewController.h"
#import "AppDelegate.h"
#import "ActiveWorkoutCell.h"

@interface ActiveWorkoutViewController ()

@end

@implementation ActiveWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleLabel.text = _workoutName;
    _exercisesTableView.allowsSelection = NO;
    [self fetchData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] == 0) {
        //Alert view: NO EXERCISES
    } else {
        _exercises = [NSMutableArray array];
        _totalSets = [NSMutableArray array];
        _currentSets = [NSMutableArray array];
        _totalReps = [NSMutableArray array];
        for (int x = 0; x < [objects count]; x++) {
            matches = objects[x];
            NSLog(@"%d %lu", x, (unsigned long)[objects count]);
            [_exercises addObject:[matches valueForKey:@"exerciseName"]];
            [_totalSets addObject:[matches valueForKey:@"sets"]];
            [_totalReps addObject:[matches valueForKey:@"reps"]];
            [_currentSets addObject:[NSNumber numberWithInteger:0]];
        }
    }
    [_exercisesTableView reloadData];
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"Cell";
    
    ActiveWorkoutCell *cell = (ActiveWorkoutCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ActiveWorkoutCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
    
    cell.exerciseNameLabel.text = [_exercises objectAtIndex:indexPath.row];
    cell.totalSetsLabel.text = [NSString stringWithFormat:@"%@  x  %@", _totalSets[indexPath.row], _totalReps[indexPath.row]];
    cell.currentSetsLabel.text = [NSString stringWithFormat:@"%@", [_currentSets objectAtIndex:indexPath.row]];
    
    cell.increaseButton.tag = indexPath.row;
    cell.decreaseButton.tag = indexPath.row;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Segue to Active set view controller
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_exercises count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void)increaseSets:(NSInteger)row {
    [self fetchData];
  //  NSInteger newValue = [_currentSets[vc.increaseButton.tag] integerValue] + 1;
 //   NSLog(@"%ld", (long)newValue);
   // _currentSets[row] = [NSNumber numberWithInteger:newValue];
  //  [_currentSets replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:5]];
   // [_exercisesTableView reloadData];
}

-(void)decreaseSets:(NSInteger)row {
    //NSLog(@"-1");
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //Send exercise name to next view controller
}


@end
