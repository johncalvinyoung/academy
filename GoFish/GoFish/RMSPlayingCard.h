//
//  RMSPlayingCard.h
//  GoFish
//
//  Created by John Calvin Young on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMSPlayingCard : NSObject
@property (nonatomic, strong, readonly) NSArray *data;

-(NSString *) rank;
-(NSString *) suit;
-(NSUInteger) value;

+(RMSPlayingCard *) createRank:(NSString *)rank suit:(NSString *)suit;
- (NSComparisonResult)compare:(RMSPlayingCard *)otherObject;
@end
