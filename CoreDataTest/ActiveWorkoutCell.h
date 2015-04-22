//
//  ActiveWorkoutCell.h
//  CoreDataTest
//
//  Created by Joe Cunningham on 22/04/2015.
//  Copyright (c) 2015 Joe Cunningham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActiveWorkoutCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentSetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalSetsLabel;
@property (weak, nonatomic) IBOutlet UIButton *decreaseButton;
@property (weak, nonatomic) IBOutlet UIButton *increaseButton;

- (IBAction)decreaseSets:(id)sender;
- (IBAction)increaseSets:(id)sender;

@end
