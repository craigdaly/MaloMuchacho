//
//  SetPlayingCard.h
//  MaloMuchacho
//
//  Created by Craig C. Daly on 5/10/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import "Card.h"

@interface SetPlayingCard : Card

@property (nonatomic) NSUInteger numberOfShapesToDraw; // 0 ≥ numberOfShapesToDraw ≤ 3 "rank"
@property (nonatomic) BOOL shaded; // is the shape shaded
@property (nonatomic, strong) NSString *shape; // triangle, rectangle or square "suit"

+ (NSArray *)validShapes;
+ (NSArray *)validNumberOfShapes;
+ (BOOL)isShapeShaded:(SetPlayingCard *)card;

@end
