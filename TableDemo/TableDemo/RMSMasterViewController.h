//
//  RMSMasterViewController.h
//  TableDemo
//
//  Created by John Calvin Young on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RMSDetailViewController;

@interface RMSMasterViewController : UITableViewController

@property (strong, nonatomic) RMSDetailViewController *detailViewController;

@end
