//
//  SetCardGameViewController.m
//  MaloMuchacho
//
//  Created by Craig C. Daly on 5/13/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "CardMatchingGame.h"
#import "SetPlayingCardDeck.h"


@interface SetCardGameViewController ()
@property (nonatomic, readwrite) NSMutableArray *setCardsFaceUp;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *testButtons;


// buttons are 70 X 50



// Set is a 3-card-matching game
@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation SetCardGameViewController



#pragma mark property instantiation 
- (NSMutableArray *)setCardsFaceUp
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (!_setCardsFaceUp) _setCardsFaceUp = [[NSMutableArray alloc] init];
    return _setCardsFaceUp;
}

- (CardMatchingGame *)game
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.testButtons count] usingDeck:[[SetPlayingCardDeck alloc] init]];
    return _game;
}

#pragma mark instantiation that needs to happen before viewDidLoad
/* instantiate any variables before viewDidLoad is called */
- (void)setUp
{
    
}

- (void)awakeFromNib
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self setUp];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setUp];
    return self;
}

// redeal cards
- (IBAction)redeal:(UIButton *)sender
{
}


#pragma mark view controller lifecycle

- (void)updateUI
{
    NSLog(@"[self.testButtons count]: %d", [self.testButtons count]);
    for(UIButton *button in self.testButtons) {
        Card *card = [self.game cardAtIndex:[self.testButtons indexOfObject: button]];
        //NSLog(@"card.contents: %@", card.contents);
        //NSLog(@"[card contents]: %@", [card contents]);
        [button setTitle:[card contents] forState: UIControlStateNormal];
        
    }
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self game];
    [self updateUI];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
