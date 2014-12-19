//
//  NewScheduleViewController.m
//  ScheduleTreatment
//
//  Created by Edmar dos Reis Silva on 12/17/14.
//  Copyright (c) 2014 Z-Sys. All rights reserved.
//

#import "NewScheduleViewController.h"

@interface NewScheduleViewController ()

@end

@implementation NewScheduleViewController
@synthesize person;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.lblName setText:person[@"name"]];
    [self.lblEmail setText:person[@"email"]];
    [self.lblPhone setText:person[@"phone_number"]];
    
     [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MainBG.png"]]];
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



- (IBAction)saveSchedule:(id)sender {
    
        PFObject *objeto = [PFObject objectWithClassName:@"Schedule"];
        PFUser *usuarioLogado = [PFUser currentUser];
        
        if (usuarioLogado){
            
            // Preenchendo valores
            objeto[@"date_hour"] = self.datePicker.date;
            objeto[@"user"] = usuarioLogado;
            objeto[@"person"]= person;
            [objeto saveInBackground];
        }
    
    
    UINavigationController *sourceViewController = self.navigationController;
    [sourceViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}
@end
