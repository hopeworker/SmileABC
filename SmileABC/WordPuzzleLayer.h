//
//  WordPuzzleLayer.h
//  SmileABC
//
//  Created by xiongwei on 13-2-4.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameManager.h"
#import "WordCard.h"
#import "AppDelegate.h"
//menu
#define MENU_FONT_NAME @"Marker Felt"
#define MENU_FONT_SIZE 24
#define MENU_NEXT_TAG 1
#define MENU_PREVIOUS_TAG 2

#define WORD_CARD_WIDTH 50

@interface WordPuzzleLayer : CCLayer
{
    NSMutableArray *alphabet;
    NSMutableArray *wordCards;
    WordLetter *selCharacter;
    CGPoint sel_orig_positon;
    NSInteger current_word_index;
    CCSprite *word_sprite;
    
    CGPoint word_sprite_position;
    CGPoint word_card_startPositon;
    CGPoint menu_position;
    CCSprite *background;
    bool playSoundLock;
    AppController *appDelegate;
}
@property (nonatomic, retain) NSMutableArray *alphabet;
@property (nonatomic, retain) NSMutableArray *wordCards;
@property (nonatomic, retain) CCSprite *word_sprite;
@property (nonatomic, retain) CCSprite *background;
@property (atomic, assign) bool playSoundLock;
@property (nonatomic, retain) AppController *appDelegate;

@end
