#import "RMSGoFishPlayer.h"
#import "RMSPlayingCard.h"

@implementation RMSGoFishPlayer
@synthesize name = _name;
@synthesize hand = _hand;
@synthesize decision = _decision;
@synthesize books = _books;
@synthesize delegate = _delegate;
@synthesize mode = _mode;

- (RMSGoFishPlayer *)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _hand = [NSMutableArray new];
        _decision = [NSMutableArray new];
        _books = [NSMutableArray new];
        _name = name;
        _mode = [NSString new];
    }
    return self;
}

- (id)init {
    return [self initWithName:@"Zaphod Beeblebrox"];
}

-(NSArray *)giveCard:(NSString *)wantedRank {
    NSMutableArray *tempArray = [NSMutableArray array];
    
    [self.hand enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([((RMSPlayingCard *)obj).rank isEqualToString: wantedRank]) {
            [tempArray addObject:obj];
        }
    }];
    [self.hand removeObjectsInArray:tempArray];
    return tempArray;
}

-(NSMutableArray *)emptyHand {
    [self.hand removeAllObjects];
    return self.hand;
}

- (void)checkForBooksOfRank:(NSString *)rank {
    NSMutableArray *tempArray = [NSMutableArray array];
    [self.hand enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([((RMSPlayingCard *)obj).rank isEqualToString: rank]) {
            [tempArray addObject:obj];
        }
    }];
    if([tempArray count] == 4) {
        [self.hand removeObjectsInArray:tempArray];
        [self.books addObject:rank];
    }
}

- (void)checkForBooks {
    for (NSUInteger i=1; i < 14; i++) {
        NSMutableArray *tempArray = [NSMutableArray array];
        [self.hand enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (((RMSPlayingCard *)obj).value==i) {
                [tempArray addObject:obj];
            }
        }];
        if([tempArray count] == 4) {
            [self.hand removeObjectsInArray:tempArray];
            RMSPlayingCard *card = [tempArray lastObject];
            NSString *rank = card.rank;
            [self.books addObject:rank];
        }
    }
}

- (RMSGoFishPlayer *)takeTurn {
    NSLog(@"%@ is taking their turn", self.name);
    RMSGoFishPlayer *nextPlayer = self;
    RMSGoFishPlayer *opponent = [self.decision objectAtIndex:(NSUInteger)0];
    NSString *rank = [self.decision objectAtIndex:(NSUInteger)1];
    NSArray *cards = [opponent giveCard:rank];
    if([cards lastObject]) {
        [self.hand addObjectsFromArray:cards];
    } else {
        RMSPlayingCard *card = [self.delegate goFish];
        if(card.rank != @"0") {
            [self.hand addObject: card];
        }
        if(![card.rank isEqualToString:rank]) {
            NSLog(@"%@",nextPlayer.name);
            [self.delegate set_CurrentPlayer: opponent];
        }
    }
    NSLog(@"Checkforbooks");
    [self checkForBooks];
    self.decision = [NSMutableArray new];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RMSGoFishGameTurnEndNotification" object:self];
    return nextPlayer;
}

- (void)robotDecision {
    //mode code from @rcdilorenzo
    
    NSMutableArray *cardRanks = [NSMutableArray new];
    for (RMSPlayingCard *card in self.hand) {
        [cardRanks addObject:card.rank];
    }
    NSCountedSet *bagOfCardRanks = [[NSCountedSet alloc] initWithArray:cardRanks];
    NSString *modeOfRanks = [NSString new];
    NSUInteger highestElementCount = 0;
    for (NSString *rank in bagOfCardRanks) {
        if ([bagOfCardRanks countForObject:rank] > highestElementCount) {
            highestElementCount = [bagOfCardRanks countForObject:rank];
            modeOfRanks = rank;
        }
    }
    
    NSArray *opponents = [self.delegate opponentsOf:self];
    NSUInteger rand = arc4random() % [opponents count];
    RMSGoFishPlayer *opponent = [opponents objectAtIndex:rand];
    self.decision = [[NSMutableArray alloc] initWithObjects:opponent,modeOfRanks,nil];
}
@end
