//
//  SchedulesViewController.m
//  ScheduleTreatment
//
//  Created by wolf on 12/16/14.
//  Copyright (c) 2014 Z-Sys. All rights reserved.
//

#import "SchedulesViewController.h"
#import <Parse/Parse.h>

@interface SchedulesViewController ()

@end

@implementation SchedulesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btnLogout setTitle:NSLocalizedString(@"Logout", nil) forState:0 ];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MainBG.png"]]];
    // Do any additional setup after loading the view.
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
*/

- (IBAction)logout:(id)sender {
    [PFUser logOut];
    [self.navigationController popViewControllerAnimated:YES];
    [self performSegueWithIdentifier:@"loginScheduleSegue" sender:self ];

}
@end
