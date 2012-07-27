#import "RMSDeckofCardsTests.h"
#import "RMSDeckofCards.h"
#import "RMSPlayingCard.h"

#import <UIKit/UIKit.h>
//#import "application_headers" as required

@implementation RMSDeckofCardsTests


- (void)testDeckofCardsCreation {
    RMSDeckofCards *deck = [RMSDeckofCards new];
    STAssertNotNil(deck, @"Deck doesn't exist");
    STAssertEquals([deck numberOfCards],(NSUInteger)52, @"Deck doesn't have 52 cards");
}

//test it exists and...
//test contains card objects
//test it has 52 cards

//test that when you draw a card, you get a card, and deck count decreases by one

- (void)testDeckDraw {
    RMSDeckofCards *deck = [RMSDeckofCards new];
    RMSPlayingCard *card = [deck draw];
    STAssertEquals([card class], [RMSPlayingCard class], @"Deck draw didn't return a card");
    STAssertEquals([deck numberOfCards], (NSUInteger)51, @"Deck didn't withdraw a card");
    RMSPlayingCard *card2 = [deck draw];
    STAssertEquals([card2 class], [RMSPlayingCard class], @"Deck draw didn't return a second card");
    STAssertEquals([deck numberOfCards], (NSUInteger)50, @"Deck didn't withdraw a second card");
}

- (void)deckHasDifferentCards {
    RMSDeckofCards *deck = [RMSDeckofCards new];
    RMSPlayingCard *card = [deck draw];
    RMSPlayingCard *card2 = [deck draw];
    STAssertFalse((card.rank == card2.rank) && (card.suit == card2.suit), @"These cards are identical.");
}

@end