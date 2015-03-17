//
//  AddExerciseDetailsViewController.h
//  CoreDataTest
//
//  Created by Joe Cunningham on 17/12/2014.
//  Copyright (c) 2014 Joe Cunningham. All rights reserved.
//

#import "ViewController.h"

@interface AddExerciseDetailsViewController : ViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) NSString *exerciseName;
@property (assign, nonatomic) NSNumber *numberOfSets;
@property (assign, nonatomic) NSNumber *numberOfReps;

@property (weak, nonatomic) IBOutlet UITextField *setsTextField;
@property (weak, nonatomic) IBOutlet UITextField *repsTextField;


@end
