//
//  CardMatchingGame.h
//  CS193P-Matchismo
//
//  Created by rodrigo brancher on 08/01/14.
//  Copyright (c) 2014 nu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count
                        usignDeck:(Deck *)deck;

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usignDeck:(Deck *)deck
                   onMatchingMode:(NSUInteger)matching_cards_count;

- (void)choseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;


@end
