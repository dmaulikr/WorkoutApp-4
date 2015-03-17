//
//  Exercises.m
//  CoreDataTest
//
//  Created by Joe Cunningham on 03/02/2015.
//  Copyright (c) 2015 Joe Cunningham. All rights reserved.
//

#import "Exercises.h"

@interface Exercises ()

@end

@implementation Exercises

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //_exerciseString = @"Bench Press";
    _exercises = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", nil];
    [self addExercises];
    [self fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchData {

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Exercise" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    //NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name = %@)", _workoutToAdd];
    //[request setPredicate:pred];
    
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    [_exercises removeAllObjects];

    
    if ([objects count] != 0) {
        
        for (int x = 0; x < [objects count]; x++) {
            matches = objects[x];
            [_exercises addObject:[matches valueForKey:@"name"]];
        }
    }
    
    
    [_tableViewExercises reloadData];

}

-(void)addExercises {
    
  //  workoutName = _exerciseString;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSError *error;
    
    NSManagedObject *newWorkout;

    
    for (int x = 0; x < [_exercises count]; x++) {
        newWorkout = [NSEntityDescription insertNewObjectForEntityForName:@"Exercise" inManagedObjectContext:context];
        [newWorkout setValue:_exercises[x] forKey:@"name"];
        [context save:&error];
    }
    
    [self fetchData];

}

- (IBAction)reset:(id)sender { //Clear the all Core Data entries
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Exercise" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    for (NSManagedObject *managedObject in objects) {
        [context deleteObject:managedObject];
    }
    
    NSError *deleteError = nil;
    if (![context save:&deleteError]) {
        NSLog(@"uh oh");
    }
    [self fetchData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_exercises count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = [_exercises objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Nothing
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
