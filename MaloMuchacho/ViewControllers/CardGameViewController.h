//
//  CardGameViewController.h
//  MaloMuchacho
//
//  Created by Craig C. Daly on 2/12/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardGameViewController : UIViewController

// cards faceUp 
@property (nonatomic, readonly) NSMutableArray *cardsFaceUp;

// # of cards faceUp
@property (nonatomic, readonly) int faceUpCards;
@end
