//
//  AddExerciseDetailsViewController.m
//  CoreDataTest
//
//  Created by Joe Cunningham on 17/12/2014.
//  Copyright (c) 2014 Joe Cunningham. All rights reserved.
//

#import "AddExerciseDetailsViewController.h"
#import "EditWorkoutViewController.h"

@interface AddExerciseDetailsViewController ()

@end

@implementation AddExerciseDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleLabel.text = _exerciseName;
    _setsTextField.keyboardType = UIKeyboardTypeNumberPad;
    _repsTextField.keyboardType = UIKeyboardTypeNumberPad;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_setsTextField resignFirstResponder];
    [_repsTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
} */


@end
