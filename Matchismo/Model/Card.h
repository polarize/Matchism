//
//  Card.h
//  Matchismo
//
//  Created by Issam Bendaas on 31.01.13.
//  Copyright (c) 2013 LetsGrow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isFaceUp) BOOL faceUP;
@property (nonatomic, getter = isUnplayable) BOOL uplayble;

-(int)match:(NSArray *)otherCards;
@end
