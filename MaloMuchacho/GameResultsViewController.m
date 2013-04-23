//
//  GameResultsViewController.m
//  MaloMuchacho
//
//  Created by Craig C. Daly on 4/12/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import "GameResultsViewController.h"
#import "GameResults.h"
@interface GameResultsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;
@property (nonatomic) SEL sortSelector; // added after lecture
@property (nonatomic, weak) NSArray *allGameResults;

@end

@implementation GameResultsViewController

@synthesize sortSelector = _sortSelector;

// return default sort selector if none is set (by score)

/*
    the setters & getters for soreSelector property is part of the control flow of the program
    when the Gameresults are sorted the appropriate sortSelector is queue'd up, said sorting is done,
    and the UI is updated.
*/
 
- (SEL)sortSelector
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if(!_sortSelector) _sortSelector = @selector(compareScoreToGameResult:);
    return _sortSelector;
}

// update the UI when changing the sort selector
- (void)setSortSelector:(SEL)sortSelector
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    _sortSelector = sortSelector;
    [self updateUI];
}


// updated the UI
- (void)updateUI
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSString *displayText = @"";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; 
    [formatter setDateStyle:NSDateFormatterShortStyle];          
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSLog(@"[[GameResults allGameResults] count]: %d", [[GameResults allGameResults] count]);
    for(GameResults *results in [[GameResults allGameResults] sortedArrayUsingSelector:self.sortSelector]) {
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %0g seconds)\n", results.score, [formatter stringFromDate:results.end], round(results.duration)]; // formatted date
        NSLog(@"%@", displayText);
        self.display.text = displayText;
    }
    NSLog(@"displaytext: %@", displayText);
    self.display.text = displayText;
}


// part of the viewController lifecycle
// sets the allGameResults property - an array of GameResult objects previously stored in NSUserDefaults
// and updates the UI
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [super viewWillAppear:animated];
    self.allGameResults = [GameResults allGameResults];
    [self updateUI];
}

// part of the viewController lifecycle
// updates the UI
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateUI];
}


/* 
  delve into this
*/
// sort by date
- (IBAction)sortByDate:(UIButton *)sender
{
    self.sortSelector = @selector(compareEndDateToGameResult:);
}

// sort by score
- (IBAction)sortByScore:(UIButton *)sender
{
    self.sortSelector = @selector(compareScoreToGameResult:);
}

// sort by game duration
- (IBAction)sortByDuration:(UIButton *)sender
{
    self.sortSelector = @selector(compareDurationToGameResult:);
}


#pragma mark initialization that needs to happen before viewDidLoad
- (void)setup
{
  // initialization that can't wait until viewDidLoad
}

- (void)awakeFromNib
{
    [self setup];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}

@end
