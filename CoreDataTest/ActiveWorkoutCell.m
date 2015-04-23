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
    _exerciseNameLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)decreaseSets:(id)sender {
    ActiveWorkoutViewController *vc = [[ActiveWorkoutViewController alloc] init];
    [vc decreaseSets:[sender tag]];
}

- (IBAction)increaseSets:(id)sender {
    ActiveWorkoutViewController *vc = [[ActiveWorkoutViewController alloc] init];
 /*   NSInteger row = [sender tag];
    if (vc.currentSets[row] < vc.totalSets[row]) {
        [vc increaseSets];
    } else {
        _increaseButton.enabled = NO;
    }*/
    [vc increaseSets:[sender tag]];
}
@end
