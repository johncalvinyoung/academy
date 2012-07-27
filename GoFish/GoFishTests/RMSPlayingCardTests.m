//
//  RMSPlayingCardTests.m
//  GoFish
//
//  Created by John Calvin Young on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RMSPlayingCardTests.h"
#import "RMSPlayingCard.h"

#import <UIKit/UIKit.h>
//#import "application_headers" as required

@implementation RMSPlayingCardTests

- (void)testCardRank {
    RMSPlayingCard *card = [RMSPlayingCard createRank:@"A"suit:@"H"];
    STAssertNotNil(card.rank, @"This card does not possess a rank!");
    STAssertEquals(card.rank, @"A", @"This card is not an Ace.");
}

- (void)testCardSuit {
    RMSPlayingCard *card = [RMSPlayingCard createRank:@"A"suit:@"H"];
    STAssertNotNil(card.suit, @"This card does not have a suit!");
    STAssertEquals(card.suit, @"H", @"This card is not a Heart.");
}

- (void)testCardValue {
    RMSPlayingCard *card = [RMSPlayingCard createRank:@"A"suit:@"H"];
    STAssertEquals(card.value, (NSUInteger)13, @"This card is not worth 13.");
}
@end
