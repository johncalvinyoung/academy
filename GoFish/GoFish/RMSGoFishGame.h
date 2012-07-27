#import <Foundation/Foundation.h>
@class RMSDeckofCards;
@class RMSGoFishPlayer;
@class RMSViewController;
//#import "RMSDeckofCards.h"

@interface RMSGoFishGame : NSObject
@property (nonatomic, strong, readonly) NSMutableArray *players;
@property (nonatomic, strong, readwrite) RMSDeckofCards *deck;
@property (nonatomic, strong, readwrite) RMSGoFishPlayer *currentPlayer;
@property (nonatomic, strong) RMSViewController *uiDelegate;

- (RMSGoFishGame *)initWithPlayers:(NSArray *)players;
- (void)deal;
- (void)gameLoop;
- (RMSGoFishPlayer *)gameScore;
- (void)gameTurn;
- (BOOL)isGameEnd;
@end
