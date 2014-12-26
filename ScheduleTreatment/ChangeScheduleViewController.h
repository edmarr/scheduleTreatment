//
//  ChangeScheduleViewController.h
//  ScheduleTreatment
//
//  Created by Edmar dos Reis Silva on 12/26/14.
//  Copyright (c) 2014 Z-Sys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ChangeScheduleViewController : UIViewController
@property (strong, nonatomic) IBOutlet PFObject *schedule;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UILabel *lblPhone;
- (IBAction)saveSchedule:(id)sender;

@end
