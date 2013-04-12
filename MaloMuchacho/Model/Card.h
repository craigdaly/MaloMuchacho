//
//  Card.h
//  MaloMuchacho
//
//  Created by Craig C. Daly on 2/11/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;


/*
@property (nonatomic, weak) NSMutableArray *cardsMatch;
@property (nonatomic, weak) NSMutableArray *cardsDoNotMatch;
*/
- (int)match:(NSArray *)otherCards;


@end
