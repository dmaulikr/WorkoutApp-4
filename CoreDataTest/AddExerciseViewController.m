//
//  AddExerciseViewController.m
//  CoreDataTest
//
//  Created by Joe Cunningham on 17/12/2014.
//  Copyright (c) 2014 Joe Cunningham. All rights reserved.
//

#import "AddExerciseViewController.h"
#import "AddExerciseDetailsViewController.h"

@interface AddExerciseViewController ()

@end

@implementation AddExerciseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_exercisesTableView reloadData];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"file" ofType:@"txt"];

    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSString *delimiter = @"\n";
    _exercisesArray = [content componentsSeparatedByString:delimiter];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = [_exercisesArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_exercisesArray count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    _selectedExerciseName = selectedCell.textLabel.text;
    [self performSegueWithIdentifier:@"addExerciseDetailsSegue" sender:self];
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Select exercise:";
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //Get the new view controller using [segue destinationViewController].
    //Pass the selected exercise to the next view
    if ([[segue identifier] isEqualToString:@"addExerciseDetailsSegue"]) {
        AddExerciseDetailsViewController *vc = [segue destinationViewController];
        vc.exerciseName = _selectedExerciseName;
    }
    
}


-(void)unwindToAddExercise:(UIStoryboardSegue *)unwindSegue {
    [_exercisesTableView reloadData];
}

@end
