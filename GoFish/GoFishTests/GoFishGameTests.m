#import "RMSGoFishGame.h"
#import "RMSGofishPlayer.h"
#import "RMSDeckofCards.h"
#import "GoFishGameTests.h"
#import "RMSPlayingCard.h"

#import <UIKit/UIKit.h>
//#import "application_headers" as required

@implementation GoFishGameTests

- (void)testCreationOfGoFishGame {
    //when you create a game, test that it exists, and that players exist
    RMSGoFishGame *game = [[RMSGoFishGame alloc] init];
    STAssertNotNil(game,@"GoFishGame does not exist");
    
    //getting back some collection of players, and we have four of them (default)
    NSArray *players = game.players;
    STAssertEquals([players count], (NSUInteger)4, @"There should be four players");
    for (RMSGoFishPlayer *player in players) {
        STAssertEqualObjects([player class], [RMSGoFishPlayer class], @"Player should be of class RMSGoFishPlayer");
    }
    //test we have a deck
    RMSDeckofCards *deck = [game deck];
    STAssertNotNil(deck, @"GoFishGame needs a deck");
}

- (void)testGameDeal {
    RMSGoFishGame *game = [RMSGoFishGame new];
    [game deal];
    RMSGoFishPlayer *player = [game.players objectAtIndex:(NSUInteger)1];
    NSMutableArray *hand = player.hand;
    STAssertEquals([hand count], (NSUInteger)5, @"The player doesn't have 5 cards.");
    STAssertEquals([game.deck.cards count], (NSUInteger)32, @"The deck doesn't have 32 cards for the pond.");
}

- (void)testPlayTurnSuccessful {
    RMSGoFishGame *game = [RMSGoFishGame new];
    [game deal];
    RMSGoFishPlayer *player1 = [game.players objectAtIndex:(NSUInteger)0];
    RMSGoFishPlayer *player2 = [game.players objectAtIndex:(NSUInteger)1];
    NSArray *player1_cards = [NSArray arrayWithObjects:[RMSPlayingCard createRank:@"J"suit:@"C"],[RMSPlayingCard createRank:@"J"suit:@"D"],[RMSPlayingCard createRank:@"J"suit:@"H"],nil];
    [[player1 emptyHand] addObjectsFromArray: player1_cards];
    [[player2 emptyHand] addObject:[RMSPlayingCard createRank:@"J"suit:@"S"]];
    game.currentPlayer = player1;
    [player1 setDecision: [NSArray arrayWithObjects:player2, @"J",nil]];
    [player1 takeTurn];
    STAssertEquals([player2.hand count], (NSUInteger)0, @"Player 2 has too many cards.");
    STAssertEquals([player1.hand count], (NSUInteger)0, @"Player 1 has too many cards.");
    STAssertEquals([player1.books count], (NSUInteger)1, @"Player 1 didn't score out his books correctly.");
}

- (void)testPlayUnsuccessful {
    RMSGoFishGame *game = [RMSGoFishGame new];
    [game deal];
    RMSGoFishPlayer *player1 = [game.players objectAtIndex:(NSUInteger)0];
    RMSGoFishPlayer *player2 = [game.players objectAtIndex:(NSUInteger)1];
    NSArray *player1_cards = [NSArray arrayWithObjects:[RMSPlayingCard createRank:@"J"suit:@"C"],[RMSPlayingCard createRank:@"J"suit:@"D"],[RMSPlayingCard createRank:@"J"suit:@"H"],nil];
    [[player1 emptyHand] addObjectsFromArray: player1_cards];
    [[player2 emptyHand] addObject: [RMSPlayingCard createRank:@"3"suit:@"S"]];
    game.currentPlayer = player1;
    [player1 setDecision: [NSArray arrayWithObjects:player2, @"J",nil]];
    [player1 takeTurn];
    STAssertEquals([player2.hand count], (NSUInteger)1, @"Player 2 has too many cards.");
    STAssertEquals([player1.hand count], (NSUInteger)4, @"Player 1 has too many cards.");
    STAssertEquals([game.deck.cards count], (NSUInteger)31, @"Player 1 didn't score out his books correctly.");
}

- (void)testEndConditionsDeck {
    RMSGoFishGame *game = [RMSGoFishGame new];
    [game deal];
    RMSGoFishPlayer *player1 = [game.players objectAtIndex:(NSUInteger)0];
    RMSGoFishPlayer *player2 = [game.players objectAtIndex:(NSUInteger)1];
    RMSGoFishPlayer *player3 = [game.players objectAtIndex:(NSUInteger)2];
    RMSGoFishPlayer *player4 = [game.players objectAtIndex:(NSUInteger)3];
    game.deck.cards = [NSMutableArray new];
    [game gameLoop];
    STAssertEquals(player1.hand.count, (NSUInteger)5,@"Player 1 played after the game was over!");
    STAssertEquals(player2.hand.count, (NSUInteger)5,@"Player 2 played after the game was over!");
    STAssertEquals(player3.hand.count, (NSUInteger)5,@"Player 3 played after the game was over!");
    STAssertEquals(player4.hand.count, (NSUInteger)5,@"Player 4 played after the game was over!");
}
    
- (void)testEndConditionsPlayer {
    RMSGoFishGame *game = [RMSGoFishGame new];
    [game deal];
    RMSGoFishPlayer *player1 = [game.players objectAtIndex:(NSUInteger)0];
    RMSGoFishPlayer *player2 = [game.players objectAtIndex:(NSUInteger)1];
    RMSGoFishPlayer *player3 = [game.players objectAtIndex:(NSUInteger)2];
    RMSGoFishPlayer *player4 = [game.players objectAtIndex:(NSUInteger)3];
    [player4 emptyHand];
    game.deck.cards = [NSMutableArray new];
    [game gameLoop];
    STAssertEquals(player1.hand.count, (NSUInteger)5,@"Player 1 played after the game was over!");
    STAssertEquals(player2.hand.count, (NSUInteger)5,@"Player 2 played after the game was over!");
    STAssertEquals(player3.hand.count, (NSUInteger)5,@"Player 3 played after the game was over!");
    STAssertEquals(player4.hand.count, (NSUInteger)0,@"Player 4 played after the game was over!");
}

- (void)testScoring {
    RMSGoFishGame *game = [RMSGoFishGame new];
    [game deal];
    RMSGoFishPlayer *player1 = [game.players objectAtIndex:(NSUInteger)0];
    RMSGoFishPlayer *player2 = [game.players objectAtIndex:(NSUInteger)1];
    NSArray *player1_cards = [NSArray arrayWithObjects:[RMSPlayingCard createRank:@"J"suit:@"C"],[RMSPlayingCard createRank:@"J"suit:@"D"],[RMSPlayingCard createRank:@"J"suit:@"H"],nil];
    [[player1 emptyHand] addObjectsFromArray: player1_cards];
    [[player2 emptyHand] addObject:[RMSPlayingCard createRank:@"J"suit:@"S"]];
    game.currentPlayer = player1;
    [player1 setDecision: [NSArray arrayWithObjects:player2, @"J",nil]];
    [player1 takeTurn];
    //[game gameLoop];
    RMSGoFishPlayer *winner = [game gameScore];
    STAssertEquals(winner, player1,@"The game didn't award the win to the clear winner, player1!");
}

@end
