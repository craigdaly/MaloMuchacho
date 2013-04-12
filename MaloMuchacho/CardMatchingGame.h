//
//  CardMatchingGame.h
//  MaloMuchacho
//
//  Created by Craig C. Daly on 3/29/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject


// designated initiliazer for my model
- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;

// flips the card @ the given index
- (void)flipCardAtIndex:(NSUInteger)index;

// returns the card @ the given index
- (Card *)cardAtIndex: (NSUInteger)index;

// game score
@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) NSString *cardMatchingState;

// YES for 2-card-matching game NO for 3 card matching game
@property (nonatomic) BOOL matchingBool;
@end
