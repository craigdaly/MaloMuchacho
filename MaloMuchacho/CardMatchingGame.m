//
//  CardMatchingGame.m
//  MaloMuchacho
//
//  Created by Craig C. Daly on 3/29/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Deck.h"

#define FLIPCOST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

@interface CardMatchingGame ()
@property (nonatomic, readwrite) int score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card(s)
@property (nonatomic, readwrite) NSString *cardMatchingState;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    if(self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
                break;
            } else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}


- (void)flipCardAtIndex:(NSUInteger)index
{
    int matchTest = 0;
    matchTest = self.matchingBool ? 2 : 1;
    
    Card *card = [self cardAtIndex:index];
    
    // are you a card & are you playable?
    if(card && !card.isUnplayable) {
        
        //NSLog(@"card.isUnplayable = %@", card.isUnplayable ? @"YES" : @"NO");
        // are you faceUp? .. we can now test for suit & rank matching. YEAH!!!
        if (!card.isFaceUp) {
            
            // an array to store the cards that are face up
            NSMutableArray *otherCards = [NSMutableArray array];
            
            // an array to store the contents of the cards ... ie J♣, 2♦
            NSMutableArray *otherCardsContents = [NSMutableArray array];
            
            // iterate through the deck & store the faceUp cards & their contents in the appropriate array
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [otherCards addObject:otherCard];
                    [otherCardsContents addObject:otherCard.contents];
                }
                
                // what cardMatchingState are we in? 2 or 3
                // assign the value of the local variable to either 2 or 1 depending on the state of the UISegmentedControl
                
                
                // NO is 2-card-matching state 
                //NSLog(@"matchTest: %@", self.matchingBool ? @"YES" : @"NO");
                
                // matchTest determines whether we're in 2 or 3 card-matching mode
                // if we're in x-card mode ... if the number of cards faceUp & playable is less than x ( i.e., x -1) tell me it was flipped
                if ([otherCards count] < matchTest) {
                    self.cardMatchingState = [NSString stringWithFormat:@"Flipped up %@", card.contents];
                } else {
                    
                    // if we're in 2-card-matching-mode & the array has 2 or more cards .. do they match?
                    // we use PlayingCard's version of match to determine whether or not the cards are a suit or rank match
                    int matchScore = [card match: otherCards];
                    
                    // if(matchscore) ... i.e.  if matchScore is NOT 0 ... matchScore will return either 1, 4, or 0
                    if(matchScore) {
                        // the card now becomes unplayable
                        card.unplayable = YES;
                        
                        // and the other faceUp cards as well
                        for(Card *card in otherCards) {
                            card.unplayable = YES;
                        }
                        // assign points as necessary
                        self.score += (matchScore * MATCH_BONUS);
                        self.cardMatchingState = [NSString stringWithFormat:@"You matched %@ & %@ for %d points!!", [card contents], [otherCardsContents componentsJoinedByString:@" & "],
                                                  (matchScore * MATCH_BONUS)];
                    } else {
                        // if there is not a match then flip over the otherCards
                        for(Card *card in otherCards) {
                            card.faceUp = NO;
                        }
                        
                        // update the mismatch penalty label
                        self.score -= MISMATCH_PENALTY;
                        self.cardMatchingState = [NSString stringWithFormat:@"%@ & %@ do not match!! %d point penalty!", [card contents], [otherCardsContents componentsJoinedByString:@" & "], MISMATCH_PENALTY];
                    }
                }
            }
            // subtract the flipcost from the score
            self.score -= FLIPCOST;
        }
        
        card.faceUp = !card.isFaceUp;
        //NSLog(@"card.faceUp = %@", card.faceUp ? @"YES" : @"NO");
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count] ? self.cards[index] : nil);
}






@end

