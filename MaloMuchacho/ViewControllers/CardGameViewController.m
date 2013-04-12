//
//  CardGameViewController.m
//  MaloMuchacho
//
//  Created by Craig C. Daly on 2/12/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardMatchingState;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;

// cards faceUp 
@property (nonatomic, readwrite) NSMutableArray *cardsFaceUp;
@property (nonatomic) NSMutableArray *pastMoves;

// UISLider
@property (weak, nonatomic) IBOutlet UISlider *slider;

// displays past moves ... past moves are stored in an NSArray
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;


// # of cards faceUp
@property (nonatomic) int faceUpCards;
@property (nonatomic) int cardsFaceUpAndDisabled;
@end

@implementation CardGameViewController


// lazily instantiate a Deck object
/*
- (Deck *)deck
{
    if(!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}
*/

- (NSMutableArray *)pastMoves
{
    if(!_pastMoves) _pastMoves = [[NSMutableArray alloc] init];
    return _pastMoves;
}



// resets the labels, enables + flips the cards on screen
- (IBAction)numberOfCardsToMatch:(UISegmentedControl *)sender
{
    if(sender.selectedSegmentIndex == 0) self.game.matchingBool = NO;
    //NSLog(@"self.game.matchingBool: %@", self.game.matchingBool ? @"YES" : @"NO");
    
    if(sender.selectedSegmentIndex == 1) self.game.matchingBool = YES;
    //NSLog(@"self.game.matchingBool: %@", self.game.matchingBool ? @"YES" : @"NO");
}

- (IBAction)sliderDisplayPastMoves:(UISlider *)sender
{
    if([self.pastMoves count]) {
        if([self.pastMoves objectAtIndex:self.slider.value]) {
            self.sliderLabel.text = [self.pastMoves objectAtIndex:self.slider.value];
        }
    }
    [self.slider setMaximumValue:([self.pastMoves count] - 1)];
}

- (IBAction)dealNewDeckResetUI:(UIButton *)sender
{
    //NSLog(@"%s", __PRETTY_FUNCTION__);
    // not bad but not as elegant as 3 lines of code
    /*
    self.flipsLabel.text = @"Score: 0";
    self.scoreLabel.text = @"flips: 0";
    self.cardMatchingState.text = @"";
    for(UIButton *button in self.cardButtons) {
        if(button.selected) {
            button.selected = !button.selected;
            button.enabled = YES;
            button.alpha = 1.0;
        }
    }
    */
    // forces the setter to instantiate a new CardMatchinGame
    self.game = nil;
    self.pastMoves = nil;
    
    // the only UI element updated in this class
    self.flipCount = 0;
    
    // toggles the segmenteControl back & forth as the Deal button is pressed
   
    for(UIButton *button in self.cardButtons) {
        button.userInteractionEnabled = YES;
        //button.alpha = 0.3;
    }
    
    self.segmentedControl.enabled = YES;
    
    /* handles the corner case where initially the buttons are frozen & the card-matching-state BOOL was not being set */
    if(self.segmentedControl.selectedSegmentIndex == 0) self.game.matchingBool = NO;
    if(self.segmentedControl.selectedSegmentIndex == 1) self.game.matchingBool = YES;
    
    // do the heavy lifting
    [self updateUI];
    //[self game];
}

- (NSMutableArray *)cardsFaceUp
{
    //NSLog(@"%s", __PRETTY_FUNCTION__);
    if(!_cardsFaceUp) _cardsFaceUp = [[NSMutableArray alloc]init];
    return _cardsFaceUp;
}

// lazily instantiate a CardMatchingGame object
- (CardMatchingGame *)game
{
    //NSLog(@"%s", __PRETTY_FUNCTION__);
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;}

// setter for the UIBUttons in the IBOutletCollection cardButtons array
- (void)setCardButtons:(NSArray *)cardButtons
{
    //NSLog(@"%s", __PRETTY_FUNCTION__);
    _cardButtons = cardButtons;
    [self updateUI];
    
}

- (void)viewDidLoad
{
    //NSLog(@"%s", __PRETTY_FUNCTION__);
    [super viewDidLoad];
    
    // sets the font of test on the UISegmentedContol
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"STHeitiSC-Medium" size:10.0], UITextAttributeFont, nil] forState:UIControlStateNormal];
    
    // on INITIAL viewDidLoad or after the game has been killed only the UISegmentedCOntrol is enabled
    
    // enables the Deal button on viewDidLoad
    //self.dealButton.userInteractionEnabled = YES;
    
    // initially disables the cardButtons
    // cardButtons will be enabled once the type of game is chosen + the Deal button has been pushed
    for(UIButton *button in self.cardButtons) {
        button.userInteractionEnabled = NO;
        button.alpha = 0.3;
    }
    
    
    // set up inital slider values
    // set slider value on launch + sliders minimumValue
    [self.slider setValue:0.0];
    [self.slider setMinimumValue:0.0];
    
    
        
    
    // initially disables the UISegmentedControl 
    [self.segmentedControl setTitle:@"2-card-match mode" forSegmentAtIndex:0];
    [self.segmentedControl setTitle:@"3-card-match mode" forSegmentAtIndex:1];
    
    //NSLog(@"[self.game.matchingBool initialVal]: %@", self.game.matchingBool ? @"YES" : @"NO");
    
}

- (void)updateUI
{
    //NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // set the sliders maxValue to the # of elements in pastMoves
    if([self.pastMoves count]) [self.slider setMaximumValue:([self.pastMoves count] + 1)];

    // background image for the  card
    UIImage *cardButtonBackgroundImage = [UIImage imageNamed:@"pie50x50.png"];
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject: cardButton]];
        
        // if the card is not faceUp
        if (!card.isFaceUp) {
            [cardButton setImage:cardButtonBackgroundImage forState: UIControlStateNormal];
        } else {
            [cardButton setImage:nil forState: UIControlStateNormal];
        }
        
        [cardButton setTitle: card.contents forState:UIControlStateSelected];
        [cardButton setTitle: card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
    }

    self.cardMatchingState.text = self.game.cardMatchingState;
    
    // store past moves ... the array will be nil'd out on deal
    
    if(self.cardMatchingState.text) {
        [self.pastMoves addObject:self.cardMatchingState.text];
        [self.slider setValue:([self.pastMoves count] - 1) animated:YES];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}




// returns the number of cards faceUp
- (int)numberOfCardsFaceUp:(NSArray *)cardButtons
{
    //NSLog(@"%s", __PRETTY_FUNCTION__);
    int faceUp = 0;
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        if(card.isFaceUp) {
            ++faceUp;
        }
    }
    self.faceUpCards = faceUp;
    return self.faceUpCards;
}

// returns an array containing the cards that are faceUp
- (NSArray *)whichCardsAreFaceUp:(NSArray *)cardButtons
{
    //NSLog(@"%s", __PRETTY_FUNCTION__);
    NSMutableArray *faceUp = [NSMutableArray array];
    for(UIButton *cardButton in cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        if(card.isFaceUp) {
            [faceUp addObject:card];
        }
    }
    self.cardsFaceUp = faceUp;
    return self.cardsFaceUp;
}

// flips card 
// disables the UISegmentedController ... took this out 
- (IBAction)flipCard:(UIButton *)sender
{
    //NSLog(@"%s", __PRETTY_FUNCTION__);
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject: sender]];
    /*
    [self.segmentedControl setEnabled:NO forSegmentAtIndex:0];
    [self.segmentedControl setEnabled:NO forSegmentAtIndex:1];
    */
    
    self.segmentedControl.enabled = NO;
    
    self.flipCount++;
    [self updateUI];
}

- (void)setFlipCount:(int)flipCount
{
    //NSLog(@"%s", __PRETTY_FUNCTION__);
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"flips: %d", self.flipCount];
}

- (BOOL)shouldAutorotate
{
    return NO;
}


@end
