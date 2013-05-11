//
//  PlayingCard.m
//  MaloMuchacho
//
//  Created by Craig C. Daly on 2/11/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import "PlayingCard.h"
#import "Card.h"

@implementation PlayingCard

@synthesize suit = _suit;

// check to see if the suit + rank of the card matches & awards points accordingly
- (int)match:(NSArray *)otherCards
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    int score = 0;
    if ([otherCards count]) {
        for(id card in otherCards) {
            if([card isKindOfClass:[PlayingCard class]]) {
                PlayingCard *otherPlayingCard = card;
                if ([otherPlayingCard.suit isEqualToString:self.suit]) {
                    score = 1;
                
                } else if (otherPlayingCard.rank == self.rank) {
                    score = 4;
                
                } else {
                    score = 0;
                    break;
                }
            }
        }
    }
    return score;
}

 // class method
 // returns an array of valid suits @[@"♣", @"♠", @"♥", @"♦"]
 // notice the syntax
+ (NSArray *)validSuits
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
   return @[@"♣", @"♠", @"♥", @"♦"];
}

 // class method
 // returns the # of elements in the rankStrings array @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"]
+ (NSUInteger)maxRank
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [self rankStrings].count-1;
}

 // returns an array of strings for ranking Card objects 
+ (NSArray *)rankStrings
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
     return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

- (NSString *)contents
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

// setter for suit property
- (void)setSuit:(NSString *)suit
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if([[PlayingCard validSuits] containsObject:suit]) _suit = suit;
    
}

// getter for suit property
// returns a ? if the suit is invalid
- (NSString *)suit
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return _suit ? _suit:@"?";
}

// setter for rank property
- (void)setRank:(NSUInteger)rank
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if(rank <= [PlayingCard maxRank]) _rank = rank;
    
}

@end
