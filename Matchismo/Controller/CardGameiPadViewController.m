//
//  CardGameiPadViewController.m
//  Matchismo
//
//  Created by Issam Bendaas on 01.02.13.
//  Copyright (c) 2013 LetsGrow. All rights reserved.
//

#import "CardGameiPadViewController.h"

#import "PlayingCardDeck.h"

#import "CardMatchingGame.h"

@interface CardGameiPadViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *lastFlipResult;

@property (nonatomic) int flipCount;

//@property (strong, nonatomic) Deck *deck;

@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation CardGameiPadViewController


-(CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count
                                                 usingDeck:[[PlayingCardDeck alloc]init]];
    }
    
    return _game;
}


-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
    
}

-(void)updateUI
{
    for(UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        [cardButton setBackgroundImage:[UIImage imageNamed:@"Matchsmo_youppi.png"] forState:UIControlStateDisabled];
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    // Update last move label
    self.lastFlipResult.text = self.game.lastMoveDescription;
    // Make sure the alpha is 1 on our label
    self.lastFlipResult.alpha = 1.0;
    
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {

    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
    
}
- (IBAction)replay:(UIButton *)sender {
    self.flipCount = 0;
    
    self.game = nil;
    [self updateUI];
    
}


@end
