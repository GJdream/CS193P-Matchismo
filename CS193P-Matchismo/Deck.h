//
//  Deck.h
//  CS193P-Matchismo
//
//  Created by rodrigo brancher on 1/8/14.
//  Copyright (c) 2014 nu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
