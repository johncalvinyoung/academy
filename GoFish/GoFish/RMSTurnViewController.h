//
//  RMSTurnViewController.h
//  GoFish
//
//  Created by John Calvin Young on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMSGoFishGame.h"

@interface RMSTurnViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) RMSGoFishGame *game;
@property (strong, nonatomic) RMSViewController *delegate;

@end
@protocol RMSTurnDelegate <NSObject>
- (void)receiveHumanInputName:(NSUInteger)opponent rank:(NSString *)rank;
@end
