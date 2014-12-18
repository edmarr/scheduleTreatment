//
//  NewScheduleViewController.h
//  ScheduleTreatment
//
//  Created by Edmar dos Reis Silva on 12/17/14.
//  Copyright (c) 2014 Z-Sys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface NewScheduleViewController : UIViewController
@property (strong, nonatomic) IBOutlet PFObject *person;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)saveSchedule:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblPhone;
@end
