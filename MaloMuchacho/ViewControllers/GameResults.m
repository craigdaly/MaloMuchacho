//
//  GameResults.m
//  MaloMuchacho
//
//  Created by Craig C. Daly on 4/17/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import "GameResults.h"

@interface GameResults ()
@property (nonatomic, readwrite) NSDate *start, *end;
@end


@implementation GameResults

#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"
#define ALL_RESULTS_KEY @"GameResult_ALL"

- (void)synchronize
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    // an NSDictionary will store the results/stats from each game ... the KEY for each unique dictionary wil be when (NSDate) it started
    NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey: ALL_RESULTS_KEY] mutableCopy];
    
    // if there isn't 1 in NSUserDefaults create one
    if(!mutableGameResultsFromUserDefaults) mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    
    // the KEY for the corresonding result
    mutableGameResultsFromUserDefaults[[self.start description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

// class method - returns all the GameResults stored in NSUserDefaults in an NSArray
 + (NSArray *)allGameResults
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    for(id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        GameResults *results = [[GameResults alloc] initFromPlist:plist];
        [allGameResults addObject:results];
    }
    NSLog(@"[allGameResults count]: %d", [allGameResults count]);
    return allGameResults;
}

// cans the data (start, end, score, etc...) in an NSDictionary for storage in NSUserDefaults ... notice the syntax
- (id)asPropertyList
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return @{ START_KEY : self.start, END_KEY : self.end, SCORE_KEY: @(self.score) };
}

// convenience initializer
// initializes an instance of this class from a plist
- (id)initFromPlist:(id)plist
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self = [self init];
    if(self) {
        if([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = (NSDictionary *)plist;
            _score = [resultDictionary[SCORE_KEY] intValue];
            _end = resultDictionary[END_KEY];
            _start = resultDictionary[START_KEY];
            if(!_start || !_end) self = nil;
            
        }
    }
    return self;
}

// designated initializer
// _start = NOW (i.e. current time, date)
// _end = _start 
- (id)init
{
    self = [super init];
    if(self) {
        _start = [NSDate date];
        _end = _start;
    }
    return self;
}

- (NSTimeInterval)duration
{
    return [self.end timeIntervalSinceDate:self.start];
}

- (void)setScore:(int)score
{
    _score = score;
    self.end = [NSDate date];
    [self synchronize];
}

// sorted by score
- (NSComparisonResult)compareScoreToGameResult:(GameResults *)otherResult
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if(self.score > otherResult.score) {
        return NSOrderedAscending;
    } else if(self.score < otherResult.score) {
        return NSOrderedDescending;
    } else {
        return NSOrderedSame;
    }
    
}

// sorted by date
- (NSComparisonResult)compareEndDateToGameResult:(GameResults *)otherResult
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [otherResult.end compare:self.end];
}


// sorted by game length
- (NSComparisonResult)compareDurationToGameResult:(GameResults *)otherResult
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (self.duration > otherResult.duration) {
        return NSOrderedDescending;
    } else if (self.duration < otherResult.duration) {
        return NSOrderedAscending;
    } else {
        return NSOrderedSame;
    }
}
@end
