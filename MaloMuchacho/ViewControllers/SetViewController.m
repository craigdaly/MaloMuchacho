//
//  SetViewController.m
//  MaloMuchacho
//
//  Created by Craig C. Daly on 4/23/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *setGameButtons;

@end

@implementation SetViewController

- (void)setUp
{
    // initialization that can't wait until viewDidLoad
}
- (void)awakeFromNib
{
    [self setUp];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setUp];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}



@end
