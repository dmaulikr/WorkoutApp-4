//
//  SelectWorkoutViewController.m
//  CoreDataTest
//
//  Created by Joe Cunningham on 06/04/2015.
//  Copyright (c) 2015 Joe Cunningham. All rights reserved.
//

#import "SelectWorkoutViewController.h"
#import "AppDelegate.h"
#import "ActiveWorkoutViewController.h"

@interface SelectWorkoutViewController ()

@end

@implementation SelectWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] == 0) {
        //Alert view: NO WORKOUTS
    } else {
        for (int x = 0; x < [objects count]; x++) {
            matches = objects[x];
            _workouts = [NSMutableArray array];
            [_workouts addObject:[matches valueForKey:@"name"]];
        }
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    _selectedWorkout = selectedCell.textLabel.text;
    [self performSegueWithIdentifier:@"activeWorkoutSegue" sender:self];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_workouts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = [_workouts objectAtIndex:indexPath.row];
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"activeWorkoutSegue"]) {
        ActiveWorkoutViewController *vc = [segue destinationViewController];
        vc.workoutName = _selectedWorkout;
    }
}


@end
