#import "RMSViewController.h"
#import "RMSViewControllerTests.h"
#import "RMSGoFishGame.h"

#import <UIKit/UIKit.h>
//#import "application_headers" as required

@interface RMSViewController (Testing)
@property (weak, nonatomic) IBOutlet UIView *handView;
@property (nonatomic, strong)RMSGoFishGame *game;
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

@end
