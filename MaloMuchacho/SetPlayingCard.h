//
//  SetPlayingCard.h
//  MaloMuchacho
//
//  Created by Craig C. Daly on 5/10/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import "Card.h"

@interface SetPlayingCard : Card

@property (nonatomic) NSNumber *numberOfShapesToDraw; // 0 ≥ numberOfShapesToDraw ≤ 3 "rank"
@property (nonatomic, weak) NSString *shaded; // is the shape shaded
@property (nonatomic, weak) NSString *shape; // triangle, rectangle or square "suit"
@property (nonatomic, weak) NSString *drawingString;
@property (nonatomic, weak) NSString *color;
@property BOOL isCardShaded;

+ (NSArray *)validShapes;
+ (NSArray *)validNumberOfShapes;
+ (NSArray *)validColors;
+ (NSArray *)validShading;
+ (NSString *)isShapeShaded:(SetPlayingCard *)card;

@end
