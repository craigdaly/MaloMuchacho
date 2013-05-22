//
//  SetPlayingCardDeck.m
//  MaloMuchacho
//
//  Created by Craig C. Daly on 5/10/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import "SetPlayingCardDeck.h"
#import "SetPlayingCard.h"

@implementation SetPlayingCardDeck


// a set card deck consists of 81 cards
- (id)init
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self = [super init];
    if (self) {
        for(NSNumber *numShapes in [SetPlayingCard validNumberOfShapes]) {
            for(NSString *color in [SetPlayingCard validColors]) {
                for(NSString *shading in [SetPlayingCard validShading]) {
                    for(NSString *shape in [SetPlayingCard validShapes]) {
                        SetPlayingCard *card = [[SetPlayingCard alloc] init];
                        card.numberOfShapesToDraw = [card numberOfShapesToDraw];
                        card.color = [card color];
                        card.shaded = [card shaded];
                        card.shape = [card shape];
                        [self addCard:card cardAtTop:YES];
                    }
                }
            }
        }
    }
    return self;
}

@end
