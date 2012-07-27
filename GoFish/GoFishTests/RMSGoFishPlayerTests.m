#import "RMSGoFishPlayerTests.h"
#import "RMSGoFishPlayer.h"
#import "RMSPlayingCard.h"
#import "RMSGoFishGame.h"

#import <UIKit/UIKit.h>
//#import "application_headers" as required

@implementation RMSGoFishPlayerTests

-(void)testPlayerHasHand {
    RMSGoFishPlayer *player = [RMSGoFishPlayer new];
    NSMutableArray *hand = player.hand;
    [hand addObject:[RMSPlayingCard createRank:@"J" suit:@"S"]];
    STAssertNotNil(hand, @"The player's hand doesn't exist.");
}

-(void)testPlayerGivesCard {
    RMSGoFishPlayer *player = [RMSGoFishPlayer new];
    NSMutableArray *hand = player.hand;
    [hand addObject:[RMSPlayingCard createRank:@"J" suit:@"S"]];
    STAssertFalse((BOOL)[[player giveCard:@"A"] lastObject], @"The player is giving you a card he doesn't have!");
    NSArray *cards = [player giveCard:@"J"];
    RMSPlayingCard *card = [cards objectAtIndex:(NSUInteger)0];
    STAssertEquals(card.rank, @"J", @"The player is giving you the incorrect card.");
}

- (void)testRobotDecision {
    RMSGoFishGame *game = [RMSGoFishGame new];
    [game deal];
    RMSGoFishPlayer *player1 = [game.players objectAtIndex:(NSUInteger)0];
    RMSGoFishPlayer *player2 = [game.players objectAtIndex:(NSUInteger)1];
    NSArray *player1_cards = [NSArray arrayWithObjects:[RMSPlayingCard createRank:@"J"suit:@"C"],[RMSPlayingCard createRank:@"J"suit:@"D"],[RMSPlayingCard createRank:@"J"suit:@"H"],[RMSPlayingCard createRank:@"Q"suit:@"D"],[RMSPlayingCard createRank:@"3"suit:@"H"],nil];
    [[player1 emptyHand] addObjectsFromArray: player1_cards];
    [[player2 emptyHand] addObject:[RMSPlayingCard createRank:@"J"suit:@"S"]];
    game.currentPlayer = player1;
    [game.currentPlayer robotDecision];
    NSMutableArray *decision = game.currentPlayer.decision;
    RMSGoFishPlayer *opponent = [decision objectAtIndex:(NSUInteger)0];
    NSString *rank = [decision objectAtIndex:(NSUInteger)1];
    STAssertTrue([game.players containsObject:opponent], @"The AI has returned a player that doesn't exist!");
    STAssertTrue(game.currentPlayer != opponent, @"The AI has asked itself for a card!");
    STAssertEquals(@"J", rank, @"The AI isn't returning the optimum rank.");
}

@end
