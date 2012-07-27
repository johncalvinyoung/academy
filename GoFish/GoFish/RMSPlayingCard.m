#import "RMSPlayingCard.h"

@interface RMSPlayingCard ()
@property (nonatomic, strong, readwrite) NSArray *data;
@end

@implementation RMSPlayingCard
@synthesize data = _data;

-(RMSPlayingCard *)initRank:(NSString *)rank 
                       suit:(NSString *)suit {
    self = [super init];
    if (self) {
        self.data = [NSArray arrayWithObjects:rank,suit, nil];

    }
    return self;
}

-(NSString *) rank {
    return [_data objectAtIndex:(NSUInteger)0];
}

-(NSString *) suit {
    return [_data objectAtIndex:(NSUInteger)1];
}

-(NSUInteger) value {
    id ranks = [NSArray arrayWithObjects:@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K",@"A", nil];
    NSUInteger index = [ranks indexOfObject: self.rank];
    return (index + (NSUInteger)1);
}

+(RMSPlayingCard *) createRank:(NSString *)rank 
                          suit:(NSString *)suit {
    id card = [self alloc];
    card = [card initRank: rank suit: suit];
    return card;
}

- (NSComparisonResult)compare:(RMSPlayingCard *)otherObject {
    if ([self value] < [otherObject value]) {
            return NSOrderedAscending;
    } else if ([self value] > [otherObject value]) {
            return NSOrderedDescending;
    } else {
            return NSOrderedSame;
    }
}
@end
