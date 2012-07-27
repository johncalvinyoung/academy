//
//  RMSEndgameViewController.h
//  GoFish
//
//  Created by John Calvin Young on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMSViewController.h"
#import "RMSGoFishPlayer.h"

@interface RMSEndgameViewController : UIViewController
@property (nonatomic, strong)RMSGoFishPlayer *winner;
@property (nonatomic, strong)RMSViewController *delegate;

@end
