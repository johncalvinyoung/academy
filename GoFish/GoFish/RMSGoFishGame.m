
#import "RMSGoFishGame.h"
#import "RMSGoFishPlayer.h"
#import "RMSDeckofCards.h"
#import "RMSViewController.h"
#import <dispatch/dispatch.h>

@interface RMSGoFishGame () <RMSMyGame>
//@property (nonatomic, strong, readwrite) NSArray *players;
//@property (nonatomic, strong, readwrite) RMSDeckofCards *deck;
@end

@implementation RMSGoFishGame
@synthesize players = _players;
@synthesize deck = _deck;
@synthesize currentPlayer = _currentPlayer;
@synthesize uiDelegate = _uiDelegate;

- (RMSGoFishGame *)initWithPlayers:(NSArray *)playerNames{
    self = [super init];
    if (self) {
        _players = [NSMutableArray new];
        for (NSString *playerName in playerNames) {
            [_players addObject:[[RMSGoFishPlayer alloc ]initWithName:playerName]];
        }
        for (RMSGoFishPlayer *player in _players) {
            player.delegate = self;
        }
        _deck = [RMSDeckofCards new];
        _currentPlayer = nil;
    }
    return self;
}

- (id)init {
    NSArray *players = [NSArray arrayWithObjects:@"Hannibal",@"Quentin",@"Octavia",@"Hyperion",nil];
    return [self initWithPlayers:players];
}

- (void)deal {
    [self.deck shuffle];
    for (RMSGoFishPlayer *player in self.players) {
        for (NSUInteger i = 0; i < 5; i++) {
            RMSPlayingCard *card = [self.deck draw];
            [player.hand addObject: card];
        }
    }
}

- (BOOL)isGameEnd {
    for (RMSGoFishPlayer *player in self.players) {
        if(player.hand.count == 0) {
            return YES;
        }
    }
    if(self.deck.cards.count == 0) {
        return YES;
    }
    return NO;
}

- (RMSGoFishPlayer *)gameScore {
    //again, partially borrowed from StackOverflow to avoid syntax issues
    
    NSMutableArray *scores = [NSMutableArray new];
    for (RMSGoFishPlayer *player in self.players) {
        [scores addObject:[NSNumber numberWithInt:player.books.count]];
    }
    int max = [[scores valueForKeyPath:@"@max.intValue"] intValue];
    NSUInteger who = [scores indexOfObject:[NSNumber numberWithInt:max]];
    return [self.players objectAtIndex:who];
}

- (void)gameLoop {
    RMSGoFishPlayer *nextPlayer = [self.players objectAtIndex:(NSUInteger)0];
    while (![self isGameEnd]) {
        [nextPlayer robotDecision];
        nextPlayer = [nextPlayer takeTurn];
        [self.uiDelegate updateUI];
    }
}

- (void)gameTurn {
    if(![self isGameEnd]) {
        [self.currentPlayer robotDecision];
        self.currentPlayer = [self.currentPlayer takeTurn];
        [self.uiDelegate updateUI];
    } else {
        [self gameScore];
    }
}

- (RMSPlayingCard *)goFish {
    return [self.deck draw];
}

- (NSArray *)opponentsOf:(RMSGoFishPlayer *)player {
    NSMutableArray *tempArray = [NSMutableArray new];
    for (RMSGoFishPlayer *otherPlayer in self.players) {
        if(otherPlayer != player) {
            [tempArray addObject: otherPlayer];
        }
    }
    return tempArray;
}
- (void)set_CurrentPlayer:(RMSGoFishPlayer *)currentPlayer {
    self.currentPlayer = currentPlayer;
}
@end
