//
//  ChangeScheduleViewController.m
//  ScheduleTreatment
//
//  Created by Edmar dos Reis Silva on 12/26/14.
//  Copyright (c) 2014 Z-Sys. All rights reserved.
//

#import "ChangeScheduleViewController.h"

@interface ChangeScheduleViewController ()

@end

@implementation ChangeScheduleViewController
@synthesize schedule;
- (void)viewDidLoad {
    [super viewDidLoad];
    PFObject *person = schedule[@"person"];
    [self.lblName setText:person[@"name"]];
    [self.lblEmail setText:person[@"email"]];
    [self.lblPhone setText:person[@"phone_number"]];
    [self.datePicker setDate:schedule[@"date_hour"]];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:253/255.0 green:245/255.0 blue:230/255.0 alpha:1.0]];}

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

- (IBAction)saveSchedule:(id)sender {
    
   PFUser *usuarioLogado = [PFUser currentUser];
    
    if (usuarioLogado){
        schedule[@"date_hour"] = self.datePicker.date;
        [schedule saveInBackground];
    }
    
    
    UINavigationController *sourceViewController = self.navigationController;
    [sourceViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

@end
