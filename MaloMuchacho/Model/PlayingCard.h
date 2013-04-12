//
//  PlayingCard.h
//  MaloMuchacho
//
//  Created by Craig C. Daly on 2/11/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (nonatomic, strong) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
+ (NSArray *)rankStrings;


@end
