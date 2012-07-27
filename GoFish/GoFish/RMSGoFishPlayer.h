#import <Foundation/Foundation.h>
@class RMSPlayingCard;
@protocol RMSMyGame;

@interface RMSGoFishPlayer : NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSMutableArray *hand;
@property (nonatomic, strong, readwrite)NSMutableArray *decision;
@property (nonatomic, strong)NSMutableArray *books;
@property (nonatomic, weak)id <RMSMyGame> delegate;
@property (nonatomic, strong, readwrite)NSString *mode;

-(RMSGoFishPlayer *)initWithName:(NSString *)name;
-(NSArray *)giveCard:(NSString *)wantedRank;
-(NSMutableArray *)emptyHand;
-(RMSGoFishPlayer *)takeTurn;
-(void)checkForBooksOfRank:(NSString *)rank;
-(void)robotDecision;
@end

@protocol RMSMyGame <NSObject>
- (RMSPlayingCard *)goFish;
- (NSArray *)opponentsOf:(RMSGoFishPlayer *)player;
- (void)set_CurrentPlayer:(RMSGoFishPlayer *)player;
@end
