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
#import "SelectWorkoutViewController.h"

@interface ActiveWorkoutViewController ()

@end

@implementation ActiveWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _exercises = [NSMutableArray array];
    _totalSets = [NSMutableArray array];
    _currentSets = [NSMutableArray array];
    _totalReps = [NSMutableArray array];
    [_finishButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    _titleLabel.text = _workoutName;
    _exercisesTableView.allowsSelection = NO;
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"WorkoutHasExercise" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    request.resultType = NSDictionaryResultType;
    request.propertiesToFetch = [NSArray arrayWithObjects:@"exerciseName", @"reps", @"sets", nil];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(workoutName == %@)", _workoutName];
    [request setPredicate:pred];
    
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] == 0) {
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No exercises!" message:@"You need to add some exercises to this workout!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        
        //[alert show];
    } else {
        [_exercises removeAllObjects];
        [_totalSets removeAllObjects];
        [_totalReps removeAllObjects];
        [_currentSets removeAllObjects];
        for (int x = 0; x < [objects count]; x++) {
            matches = objects[x];
            // NSLog(@"%d %lu", x, (unsigned long)[objects count]);
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
    
    cell.currentSetsLabel.tag = indexPath.row;
    
    if ([_currentSets[indexPath.row] integerValue] == [_totalSets[indexPath.row] integerValue]) {
        cell.contentView.backgroundColor = [UIColor colorWithRed:1 green:0.541 blue:0.541 alpha:1];
    }
    
    cell.delegate = self;
    
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
/*
 -(void)increaseSets:(NSInteger)row {
 [self getData];
 //  NSInteger newValue = [_currentSets[vc.increaseButton.tag] integerValue] + 1;
 //   NSLog(@"%ld", (long)newValue);
 // _currentSets[row] = [NSNumber numberWithInteger:newValue];
 //  [_currentSets replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:5]];
 // [_exercisesTableView reloadData];
 }
 
 -(void)decreaseSets:(NSInteger)row {
 //NSLog(@"-1");
 }*/

-(void)changeSetsForViewController:(ActiveWorkoutCell *)viewController row:(NSInteger)row {
    //[self getData];
    
    if ([_currentSets[row] integerValue] < [_totalSets[row] integerValue]) {
        NSInteger newValue = [_currentSets[row] integerValue] + 1;
        [_currentSets replaceObjectAtIndex:row withObject:[NSNumber numberWithInteger:newValue]];
    }
    //[_currentSets replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:5]];
    
    NSInteger setFinishCount = 0;
    for (int x = 0; x < [_exercises count] ; x++) {
        if ([_currentSets[x] integerValue] == [_totalSets[x] integerValue]) {
            setFinishCount += 1;
        }
    }
    if (setFinishCount == [_exercises count]) {
        _finishButton.enabled = YES;
    }
    
    [_exercisesTableView reloadData];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //alertview if sender is done button
    if (sender == _finishButton) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Workout completed" message:@"Good job!" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
}


@end
