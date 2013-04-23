//
//  GameResults.h
//  MaloMuchacho
//
//  Created by Craig C. Daly on 4/17/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

/*
    the result of a game. an instance of this class returns an object whose properties are 2 NSDate(s) (start, end) which 
    indicate the start & end dates of a game.
    
    an NSTimeInterval (duration) indicating the length of the game in seconds.
 
    an int (score) indicating the score of the game.
 
*/

#import <Foundation/Foundation.h>

@interface GameResults : NSObject

@property (nonatomic, readonly) NSDate *start, *end;
@property (nonatomic, readonly) NSTimeInterval duration;
@property (nonatomic) int score;

// class method
// returns all the game results stored in NSUserDefaults
+ (NSArray *)allGameResults;

// array sorting by score, date or duration
- (NSComparisonResult)compareScoreToGameResult:(GameResults *)otherResult;
- (NSComparisonResult)compareEndDateToGameResult:(GameResults *)otherResult;
- (NSComparisonResult)compareDurationToGameResult:(GameResults *)otherResult;
@end
