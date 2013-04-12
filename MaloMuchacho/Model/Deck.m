//
//  Deck.m
//  MaloMuchacho
//
//  Created by Craig C. Daly on 2/11/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property(nonatomic, strong) NSMutableArray *cards;
@end

@implementation Deck

@synthesize cards = _cards;


 // getter for the array that holds a deck of cards
 // lazy instantiation
- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

// add this card to the deck. either @ the bottom of the deck or @ the top.
- (void)addCard:(Card *)card cardAtTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}


// returns a random card form the deck
- (Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    if(self.cards.count) { // if the array is not empty
        unsigned index = arc4random() % self.cards.count;
        randomCard = [self.cards objectAtIndex:index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}

@end
