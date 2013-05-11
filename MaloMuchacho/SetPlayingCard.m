//
//  SetPlayingCard.m
//  MaloMuchacho
//
//  Created by Craig C. Daly on 5/10/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import "SetPlayingCard.h"

@implementation SetPlayingCard

@synthesize shape = _shape;



// shape "suit" getter
- (NSString *)shape
{
    return _shape ? _shape : @"?";
}

- (void)setShape:(NSString *)shape
{
    if ([[SetPlayingCard validShapes] containsObject:shape]) _shape = shape;
}

// setter for the # of shapes "rank" to draw on each card
- (void)setNumberOfShapesToDraw:(NSUInteger)numberOfShapesToDraw
{
    if(numberOfShapesToDraw <= [SetPlayingCard validNumberOfShapes].count && numberOfShapesToDraw > 0) _numberOfShapesToDraw = numberOfShapesToDraw;
        
}

+ (int)maxNumberOfShapesOnCard
{
    return [self validNumberOfShapes].count -1;
}

// valid shapes "suit" of the card
+ (NSArray *)validShapes
{
    return @[@"triangle", @"square", @"rectangle"];
}


// the "rank" of the card 
+ (NSArray *)validNumberOfShapes
{
    return @[@"?", @1, @2, @3];
}

+ (BOOL)isShapeShaded:(SetPlayingCard *)card
{
    return card.shaded ? YES:NO;
}

@end
