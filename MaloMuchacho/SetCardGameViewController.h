//
//  SetCardGameViewController.h
//  MaloMuchacho
//
//  Created by Craig C. Daly on 5/13/13.
//  Copyright (c) 2013 The Grand Scheme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardGameViewController : UIViewController

// an array of setCards face up in the UI
@property (nonatomic, readonly) NSMutableArray *setCardsFaceUp;

// # of set cards face up in the UI
// the # of cards should == [setCardsFaceUp  count]
@property (readonly) int numberOfSetCardsFaceUp;





@end
