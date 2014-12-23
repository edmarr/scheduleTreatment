//
//  SchedulesTableViewController.m
//  ScheduleTreatment
//
//  Created by Edmar dos Reis Silva on 12/17/14.
//  Copyright (c) 2014 Z-Sys. All rights reserved.
//

#import "SchedulesTableViewController.h"
#import <Parse/Parse.h>

@interface SchedulesTableViewController ()

@end

@implementation SchedulesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self remoteUpdate];
    });
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MainBG.png"]]];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1.0]];
    [self.tabBarController.tabBar setBackgroundColor: [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1.0]];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellSchedule" forIndexPath:indexPath];
    
    PFObject *objeto = [self.list objectAtIndex:indexPath.row];
    PFObject *person = objeto[@"person"];
    cell.textLabel.text = person[@"name"];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSDate *dateSchedule = objeto[@"date_hour"];
    NSString *strDate = [dateFormatter stringFromDate:objeto[@"date_hour"]];
    cell.detailTextLabel.text = strDate;
    if(dateSchedule.timeIntervalSince1970 >  [NSDate new].timeIntervalSince1970){
        [cell setBackgroundColor: [UIColor colorWithRed:253/255.0 green:245/255.0 blue:230/255.0 alpha:1.0]];
    }else{
        [cell setBackgroundColor:[UIColor colorWithRed:255/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]];
    }
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)logout:(id)sender {
    [PFUser logOut];
    [PFUser new];
    [self performSegueWithIdentifier:@"returnLoginSegue" sender:self ];
}

-(void)remoteUpdate
{
    // Listar tudo
    PFQuery *query = [PFQuery queryWithClassName:@"Schedule"];
    NSDateFormatter *gdf = [NSDateFormatter new];
    [gdf  setTimeZone: [NSTimeZone timeZoneWithName:@"GMT"]];
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:flags fromDate:[NSDate new ]];
    NSDate* dateOnly = [[calendar dateFromComponents:components] dateByAddingTimeInterval:[[NSTimeZone localTimeZone]secondsFromGMT]];
    [query whereKey:@"date_hour" greaterThanOrEqualTo: dateOnly];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query orderByAscending:@"date_hour"];
    [query includeKey:@"person"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            self.list = objects;
            
            // Parar o loading do refresh
            [self.refreshControl endRefreshing];
            
            // Atualizar os dados da table view
            [self.tableView reloadData];
        }
    }];
}

@end
