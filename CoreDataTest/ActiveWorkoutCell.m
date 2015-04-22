//
//  ActiveWorkoutCell.m
//  CoreDataTest
//
//  Created by Joe Cunningham on 22/04/2015.
//  Copyright (c) 2015 Joe Cunningham. All rights reserved.
//

#import "ActiveWorkoutCell.h"
#import "ActiveWorkoutViewController.h"

@implementation ActiveWorkoutCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)decreaseSets:(id)sender {
    ActiveWorkoutViewController *vc = [[ActiveWorkoutViewController alloc] init];
    
    NSInteger value = [vc.currentSets[[sender tag]] integerValue];
    NSInteger newValue = value - 1;
    vc.currentSets[[sender tag]] = [NSNumber numberWithInteger:newValue];
}

- (IBAction)increaseSets:(id)sender {
    ActiveWorkoutViewController *vc = [[ActiveWorkoutViewController alloc] init];
    
    NSInteger value = [vc.currentSets[[sender tag]] integerValue];
    NSInteger newValue = value + 1;
    vc.currentSets[[sender tag]] = [NSNumber numberWithInteger:newValue];
    NSLog(@"%@", [NSNumber numberWithInteger:newValue]);

}
@end
