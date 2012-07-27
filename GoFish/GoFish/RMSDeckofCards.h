#import <Foundation/Foundation.h>
@class RMSPlayingCard;

@interface RMSDeckofCards : NSObject
@property (nonatomic, strong) NSMutableArray *cards;

- (NSUInteger)numberOfCards;
- (RMSPlayingCard *)draw;
- (RMSDeckofCards *)add_card:(RMSPlayingCard *)card;
- (RMSDeckofCards *)shuffle;
@end
