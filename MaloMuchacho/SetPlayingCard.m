//
//  SetPlayingCard.m
//  MaloMuchacho
//
//  Created by Craig C. Daly on 5/10/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import "SetPlayingCard.h"

#define THREE 3
#define ONE 1

@implementation SetPlayingCard

@synthesize shape = _shape;
@synthesize numberOfShapesToDraw = _numberOfShapesToDraw;
@synthesize shaded = _shaded;
@synthesize color = _color;


#pragma mark lazy instantiation

- (NSString *)drawingString
{
    if(!_drawingString) _drawingString = @"";
    return _drawingString;
}

- (NSString *)contents
{
    if(_drawingString) return self.drawingString;
    else return @"?";
}

- (NSString *)color
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    _color = [[SetPlayingCard validColors] objectAtIndex:(arc4random() % [SetPlayingCard validColors].count)];
    self.drawingString = [self.drawingString stringByAppendingString:_color];
    return _color;
}

- (void)setColor:(NSString *)color
{
    if([[SetPlayingCard validColors] containsObject:color]) _color = color;
}


// the # of shapes are randomly selected 
- (NSNumber *)numberOfShapesToDraw
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    //NSArray *validNumberOfShapes = [SetPlayingCard validNumberOfShapes];
    _numberOfShapesToDraw = [[SetPlayingCard validNumberOfShapes] objectAtIndex:(arc4random() % [SetPlayingCard validNumberOfShapes].count)];
    
    // number of shapes to draw
    self.drawingString = [self.drawingString stringByAppendingString:[NSString stringWithFormat:@"%@", _numberOfShapesToDraw]];
    return _numberOfShapesToDraw;
}


// setter for the # of shapes "rank" to draw on each card
- (void)setNumberOfShapesToDraw:(NSNumber *)numberOfShapesToDraw
{
    if([[SetPlayingCard validNumberOfShapes] containsObject:numberOfShapesToDraw]) _numberOfShapesToDraw = numberOfShapesToDraw;
}

// randomly select whether the shape is shaded
- (NSString *)shaded
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    _shaded = [[SetPlayingCard validShading] objectAtIndex: (arc4random() % [SetPlayingCard validShading].count)];
    self.drawingString = [self.drawingString stringByAppendingString: _shaded];
    return _shaded;
}

- (void)setShaded:(NSString *)shaded
{
    if ([[SetPlayingCard validShading] containsObject:shaded]) _shaded = shaded;
}

// shape "suit" getter
- (NSString *)shape
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    _shape = [[SetPlayingCard validShapes] objectAtIndex:(arc4random() % [SetPlayingCard validShapes].count)];
    self.drawingString = [self.drawingString stringByAppendingString:_shape];
    //NSLog(@"%@", self.drawingString);
    return _shape;
}

- (void)setShape:(NSString *)shape
{
    if ([[SetPlayingCard validShapes] containsObject:shape]) _shape = shape;
}

+ (int)maxNumberOfShapesOnCard
{
    return [self validNumberOfShapes].count;
}

// valid shapes "suit" of the card
+ (NSArray *)validShapes
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return @[@"triangle", @"square", @"rectangle"];
}

+ (NSArray *)validShading
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return @[@"", @"squiggly", @"solid"];
}

+ (NSArray *)validColors
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return @[@"red", @"black", @"green"];
}


// the "rank" of the card 
+ (NSArray *)validNumberOfShapes
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return @[[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3]];
}

+ (NSString *)isShapeShaded:(SetPlayingCard *)card
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [card shaded];
}

- (int)match:(NSArray *)otherCards
{
    return 0;
}

@end
