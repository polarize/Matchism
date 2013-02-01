//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Issam Bendaas on 31.01.13.
//  Copyright (c) 2013 LetsGrow. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic) int flipCount;

//@property (strong, nonatomic) Deck *deck;

@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation CardGameViewController



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
    
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}


- (IBAction)flipCard:(UIButton *)sender
{
    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
     
}
- (IBAction)replay:(UIButton *)sender {
    self.flipCount = 0;
   // _game = [[CardMatchingGame alloc]initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc]init]];
    
    self.game = nil;
    [self updateUI];
    
}


@end
