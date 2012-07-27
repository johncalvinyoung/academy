#import "RMSViewController.h"

@interface RMSViewController ()
@property (weak, nonatomic) IBOutlet UIView *handView;


@end

@implementation RMSViewController
@synthesize handView = _handView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setHandView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)drawHand {
    CGPoint location = CGPointMake ((CGFloat) 0, (CGFloat) 0);
    NSString *rank = @"3";
    NSString *suit = @"H";
    
    UIImage *cardImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@.png", [[suit substringToIndex:1] lowercaseString], [[rank substringToIndex:1] lowercaseString]]];
    UIImageView *cardView = [[UIImageView alloc] initWithFrame:CGRectMake(location.x+20, location.y, cardImage.size.width, cardImage.size.height)];
    [cardView setImage:cardImage];
    [self.handView addSubview: cardView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
