#import "RMSDeckofCards.h"
#import "RMSPlayingCard.h"

@implementation RMSDeckofCards
@synthesize cards = _cards;


- (id)init {
    self = [super init];
    if (self) {
        _cards = [NSMutableArray new];
        id ranks = [NSArray arrayWithObjects:@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K",@"A", nil];
        id suits = [NSArray arrayWithObjects:@"C",@"D",@"S",@"H", nil];
        for (id suit in suits) {
            for (id rank in ranks) {
                RMSPlayingCard *card = [RMSPlayingCard createRank: rank suit: suit];
                [_cards addObject: card];
            }
        }
    }
    return self;
}

- (NSUInteger)numberOfCards {
    return [_cards count];
}

- (RMSPlayingCard *)draw {
    if([_cards lastObject]) {
        RMSPlayingCard *card = [_cards lastObject];
        [_cards removeLastObject];
        return card;
    } else {
        return nil;
    }
}

- (RMSDeckofCards *) add_card:(RMSPlayingCard *)card {
    [_cards addObject:card];
    return self;
}
- (RMSDeckofCards *)shuffle {
    
    NSUInteger count = [self.cards count];
    for (NSUInteger i = 0; i < count; ++i) {
        int nElements = count - i;
        int n = (arc4random() % nElements) + i;
        [self.cards exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    return self;
}
@end
