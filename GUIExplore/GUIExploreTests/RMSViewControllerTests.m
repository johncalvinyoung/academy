//
//  RMSViewControllerTests.m
//  GUIExplore
//
//  Created by John Calvin Young on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RMSViewControllerTests.h"
#import "RMSViewController.h"

#import <UIKit/UIKit.h>
//#import "application_headers" as required

@interface RMSViewController (Testing)
@property (weak, nonatomic) IBOutlet UIView *handView;
@end

@interface RMSViewControllerTests ()
    @property (nonatomic, strong) RMSViewController *rmsViewController;
@end

@implementation RMSViewControllerTests
    @synthesize rmsViewController = _rmsViewController;

- (void) setUp {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:[NSBundle mainBundle]];
    self.rmsViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"homeScreen"];
    [[[UIApplication sharedApplication] delegate] window].rootViewController = self.rmsViewController;      
}
- (void) testCardAtStartup {
    [self.rmsViewController drawHand];
    STAssertTrue([[self.rmsViewController.handView.subviews objectAtIndex:(NSUInteger)0] isKindOfClass:[UIImageView class]],@"The card isn't shaped right.");
}

@end
