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
    _currentSetsLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(increase)];
    [_currentSetsLabel addGestureRecognizer:tapGesture];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
/*- (IBAction)decreaseSets:(id)sender {
 id<ActiveWorkoutCellDelegate> strongDelegate = self.delegate;
 
 if ([strongDelegate respondsToSelector:@selector(changeSetsForViewController:increase:row:)]) {
 [strongDelegate changeSetsForViewController:self increase:NO row:[sender tag]];
 }
 
 
 
 //[vc decreaseSets:[sender tag]];
 }*/

-(void)increase {
    id<ActiveWorkoutCellDelegate> strongDelegate = self.delegate;
    
    if ([strongDelegate respondsToSelector:@selector(changeSetsForViewController:row:)]) {
        [strongDelegate changeSetsForViewController:self row:[_currentSetsLabel tag]];
    }
}
/*
 - (IBAction)increaseSets:(id)sender {
 NSInteger row = [sender tag];
 if (vc.currentSets[row] < vc.totalSets[row]) {
 [vc increaseSets];
 } else {
 _increaseButton.enabled = NO;
 }
 //[vc increaseSets:[sender tag]];
 
 id<ActiveWorkoutCellDelegate> strongDelegate = self.delegate;
 
 if ([strongDelegate respondsToSelector:@selector(changeSetsForViewController:increase:row:)]) {
 [strongDelegate changeSetsForViewController:self increase:YES row:[sender tag]];
 }
 
 } */
@end
