//
//  RMSEndgameViewController.m
//  GoFish
//
//  Created by John Calvin Young on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RMSEndgameViewController.h"
#import "RMSGoFishPlayer.h"

@interface RMSEndgameViewController ()
@property (strong, nonatomic) IBOutlet UILabel *winnerOutlet;

@end

@implementation RMSEndgameViewController
@synthesize winnerOutlet;
@synthesize winner = _winner;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.winnerOutlet.text = [NSString stringWithFormat:@"Winner: %@",self.winner.name];
}

- (void)viewDidUnload
{
    [self setWinnerOutlet:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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