//
//  Deck.h
//  MaloMuchacho
//
//  Created by Craig C. Daly on 2/11/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card cardAtTop:(BOOL)atTop;
- (Card *)drawRandomCard;

@end
