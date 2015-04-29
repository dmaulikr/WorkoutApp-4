//
//  ActiveWorkoutCell.h
//  CoreDataTest
//
//  Created by Joe Cunningham on 22/04/2015.
//  Copyright (c) 2015 Joe Cunningham. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActiveWorkoutCellDelegate;

@interface ActiveWorkoutCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentSetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalSetsLabel;
@property (weak, nonatomic) IBOutlet UIButton *increaseButton;

@property (weak, nonatomic) id<ActiveWorkoutCellDelegate> delegate;

-(void)increase;

@end

@protocol ActiveWorkoutCellDelegate <NSObject>

- (void)changeSetsForViewController:(ActiveWorkoutCell*)viewController row:(NSInteger)row;

@end