//
//  ActiveWorkoutViewController.h
//  CoreDataTest
//
//  Created by Joe Cunningham on 06/04/2015.
//  Copyright (c) 2015 Joe Cunningham. All rights reserved.
//

#import "ViewController.h"
#import "ActiveWorkoutCell.h"

@interface ActiveWorkoutViewController : ViewController <UITableViewDataSource, UITableViewDelegate, ActiveWorkoutCellDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *exercisesTableView;
@property (strong, nonatomic) NSMutableArray *exercises;
@property (strong, nonatomic) NSMutableArray *currentSets;
@property (strong, nonatomic) NSMutableArray *totalSets;
@property (strong, nonatomic) NSMutableArray *totalReps;
@property (strong, nonatomic) NSString *workoutName;
@property (strong, nonatomic) NSString *lol;


-(void)increaseSets:(NSInteger)row;
-(void)decreaseSets:(NSInteger)row;

-(void)getData;

@end