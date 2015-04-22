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
    // Do any additional setup after loading the view.
    _titleLabel.text = _workoutName;
    _exercisesTableView.allowsSelection = NO;
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"WorkoutHasExercise" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    request.resultType = NSDictionaryResultType;
    //request.propertiesToFetch = [NSArray arrayWithObjects:@"exerciseName", @"reps", @"sets", nil];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(workoutName = %@)", _workoutName];
    [request setPredicate:pred];

    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] == 0) {
        //Alert view: NO EXERCISES
    } else {
        for (int x = 0; x < [objects count]; x++) {
            matches = objects[x];
            _exercises = [NSMutableArray array];
            _totalSets = [NSMutableArray array];
            _currentSets = [NSMutableArray array];
            [_exercises addObject:[matches valueForKey:@"exerciseName"]];
            [_totalSets addObject:[matches valueForKey:@"sets"]];
            [_currentSets addObject:[NSNumber numberWithInteger:0]];
        }
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"Cell";
    
    ActiveWorkoutCell *cell = (ActiveWorkoutCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ActiveWorkoutCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
    
    cell.exerciseNameLabel.text = [_exercises objectAtIndex:indexPath.row];
    cell.totalSetsLabel.text = [NSString stringWithFormat:@"%@", [_totalSets objectAtIndex:indexPath.row]];
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




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //Send exercise name to next view controller
}


@end
