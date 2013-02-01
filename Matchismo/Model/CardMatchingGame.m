//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Issam Bendaas on 31.01.13.
//  Copyright (c) 2013 LetsGrow. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;// of Card
@property (nonatomic) int historyCount;
@property (nonatomic) int score;

@end

@implementation CardMatchingGame


-(NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc]init];
    }
    return _cards;
}

-(NSMutableDictionary *)flipHistory
{
    if (!_flipHistory) {
        _flipHistory = [[NSMutableDictionary alloc]init];
    }
    return _flipHistory;
}

-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0 ; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            }else
            {
                self.cards[i] = card;
            }
        }
        
    }
    
    return self;
}
#define FLIP_COST 1

#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isUnplayable) {
        //see if flipping this card up create a match
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayble = YES;
                        card.unplayble = YES;
                        self.score += matchScore * MATCH_BONUS;
                        
                        // Create the description of the move when there is a match
                        self.lastMoveDescription = [NSString stringWithFormat:
                                                    @"Matched %@%@%@%@%d%@", card.contents,
                                                    @" & ", otherCard.contents,
                                                    @" for ", matchScore * MATCH_BONUS, @" points"];
                        
                    } else {
                        otherCard.faceUP = NO;
                        self.score -= MISMATCH_PENALTY;
                        // Create the description of the move when there is a mismatch
                        self.lastMoveDescription = [NSString stringWithFormat:@"%@%@%@%@%d%@",
                                                    card.contents, @" & ",
                                                    otherCard.contents, @" don't match! ",
                                                    MISMATCH_PENALTY, @" point penalty!"];
                    }
                    break;
                }else {
                    // Create the description of the move when a card is flipped up
                    self.lastMoveDescription = [NSString stringWithFormat:@"Flipped up %@", card.contents];
                }
                
            }
            self.score -= FLIP_COST;
            // Add the description of the move to our dictionary of history
            [self.flipHistory setValue:self.lastMoveDescription forKey:[NSString stringWithFormat:@"%d", self.historyCount++]];
        }
        
        
        
        card.faceUP = !card.isFaceUp;
    }
    
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
    
}


@end
