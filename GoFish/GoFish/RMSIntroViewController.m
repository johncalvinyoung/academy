//
//  RMSIntroViewController.m
//  GoFish
//
//  Created by John Calvin Young on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RMSIntroViewController.h"
#import "RMSViewController.h"
@interface RMSIntroViewController ()
@property (weak, nonatomic) IBOutlet UITextField *playerName;
@end

@implementation RMSIntroViewController
@synthesize playerName = _playerName;
- (IBAction)submitName:(id)sender {
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender{
    if([[segue identifier] isEqualToString:@"startGame"]){
        RMSViewController *rmsVC = (RMSViewController *)[segue destinationViewController];
        rmsVC.playerName = self.playerName.text;
        rmsVC.delegate = self;
    }
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/



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
