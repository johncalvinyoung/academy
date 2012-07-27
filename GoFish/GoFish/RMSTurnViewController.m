//
//  RMSTurnViewController.m
//  GoFish
//
//  Created by John Calvin Young on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RMSTurnViewController.h"
#import "RMSGoFishPlayer.h"
#import "RMSPlayingCard.h"
#import "RMSViewController.h"

@interface RMSTurnViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation RMSTurnViewController
@synthesize pickerView = _pickerView;
@synthesize game = _game;
@synthesize delegate = _delegate;
- (IBAction)submitPlay:(id)sender {
    
    NSArray *displaySortedHand = (NSMutableArray *)[self.game.currentPlayer.hand sortedArrayUsingSelector:@selector(compare:)];
    NSInteger rank = [self.pickerView selectedRowInComponent:1];
    NSInteger opponent = [self.pickerView selectedRowInComponent:0];
    NSString *choiceRank = [[displaySortedHand objectAtIndex:(NSInteger)rank] rank];
    [self dismissModalViewControllerAnimated:YES];
    [self.delegate receiveHumanInputName:(NSUInteger)opponent rank:(NSString *)choiceRank];
    
}

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setPickerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
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
#pragma mark - pickerView delegate implementation

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(component == 0) {
        return 3;
    } else {
        return self.game.currentPlayer.hand.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return (CGFloat)40;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if(component == 0) {
        return (CGFloat)180;
    } else {
        return (CGFloat)300;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component == 0) {
        if(row == 0) {
            return @"Quentin";
        } else if(row == 1) {
            return @"Octavia";
        } else {
            return @"Hyperion";
        }
    } else {
        NSArray *displaySortedHand = (NSMutableArray *)[self.game.currentPlayer.hand sortedArrayUsingSelector:@selector(compare:)];
        return [[displaySortedHand objectAtIndex:(NSUInteger)row] rank];
    }
}
@end
