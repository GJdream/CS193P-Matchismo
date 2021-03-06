//
//  CardGameViewController.m
//  CS193P-Matchismo
//
//  Created by rodrigo brancher on 1/8/14.
//  Copyright (c) 2014 nu. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchingModeSegmentControl;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
    if (!_game) _game = [self createGameOnMatchingMode:[self.matchingModeSegmentControl selectedSegmentIndex]+2];
    return _game;
}

- (CardMatchingGame *)createGameOnMatchingMode:(NSUInteger)matching_cards_count
{
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                             usignDeck:[self createDeck]
                                        onMatchingMode:matching_cards_count];
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchMatchingModeSegmentControl:(UISegmentedControl *)sender
{
    [self startNewGame];
}

- (IBAction)touchDealCardsButton:(UIButton *)sender {
    [self startNewGame];
}

- (void)startNewGame
{
    self.game = nil;
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game choseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"CardFront" : @"CardBack"];
}

@end
