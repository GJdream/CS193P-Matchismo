//
//  CardMatchingGame.m
//  CS193P-Matchismo
//
//  Created by rodrigo brancher on 08/01/14.
//  Copyright (c) 2014 nu. All rights reserved.
//

#import "CardMatchingGame.h"


@interface CardMatchingGame ()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic) NSUInteger matching_cards_count;
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOSE = 1;

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usignDeck:(Deck *)deck onMatchingMode:(NSUInteger)matching_cards_count
{
    self = [super init];
    
    if (self) {
        self.matching_cards_count = matching_cards_count;

        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (instancetype)initWithCardCount:(NSUInteger)count usignDeck:(Deck *)deck
{
    return [self initWithCardCount:count usignDeck:deck onMatchingMode:2];
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)choseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            NSMutableArray *chosen_cards = [[NSMutableArray alloc] init];

            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [chosen_cards addObject:otherCard];

                    if ([chosen_cards count] >= self.matching_cards_count-1) {
                        int matchScore = [card match:chosen_cards];

                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;

                            card.matched = YES;
                            for (Card *chosen_card in chosen_cards) {
                                chosen_card.matched = YES;
                            }
                        } else {
                            for (Card *chosen_card in chosen_cards) {
                                self.score -= MISMATCH_PENALTY;
                                chosen_card.chosen = NO;
                            }
                        }

                        break;
                    }
                }
            }
            self.score -= COST_TO_CHOSE;
            card.chosen = YES;
        }
    }
}

@end
