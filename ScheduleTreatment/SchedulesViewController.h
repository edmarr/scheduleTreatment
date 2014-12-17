//
//  SchedulesViewController.h
//  ScheduleTreatment
//
//  Created by wolf on 12/16/14.
//  Copyright (c) 2014 Z-Sys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchedulesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
- (IBAction)logout:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnLogout;

@end
