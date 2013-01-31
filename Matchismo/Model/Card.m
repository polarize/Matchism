//
//  Card.m
//  Matchismo
//
//  Created by Issam Bendaas on 31.01.13.
//  Copyright (c) 2013 LetsGrow. All rights reserved.
//

#import "Card.h"

@implementation Card


-(int)match:(NSArray *)otherCards
{
    int score = 0;
    for(Card *card in otherCards)
    {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
        
    }
    
    return  score;
}

@end
