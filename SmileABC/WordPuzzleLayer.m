//
//  WordPuzzleLayer.m
//  SmileABC
//
//  Created by xiongwei on 13-2-4.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "WordPuzzleLayer.h"


@implementation WordPuzzleLayer
@synthesize alphabet;
@synthesize wordCards;
@synthesize word_sprite;
@synthesize background;
@synthesize playSoundLock;
@synthesize appDelegate;
-(CCSprite *)background
{
    if (background == nil)
    {
        background = [[CCSprite alloc] initWithFile:@"c.jpg"];
    }
    return background;
}
-(CCSprite *)word_sprite
{
    if (word_sprite == nil)
    {
        word_sprite = [[CCSprite alloc] initWithFile:@"ant.png"];
    }
    return word_sprite;
}


-(void) increase_word_index
{
    if ([appDelegate.alphabet_words count])
    {
        current_word_index = (current_word_index + 1)%[appDelegate.alphabet_words count];
    }
}

-(void) decrease_word_index
{
    if (current_word_index == 0)
    {
        current_word_index = [appDelegate.alphabet_words count];
    }
    if ((current_word_index >= 1)&&([appDelegate.alphabet_words count] >= 1))
    {
        current_word_index = (current_word_index - 1)%[appDelegate.alphabet_words count];
    }
}

-(NSMutableArray *)alphabet
{
    if (alphabet == nil)
    {
        alphabet = [[NSMutableArray alloc] init];
    }
    return alphabet;
}

-(NSMutableArray *)wordCards
{
    if (wordCards == nil)
    {
        wordCards = [[NSMutableArray alloc] init];
    }
    return wordCards;
}

-(void) add_WordCard:(WordCard *)card
{
    [card addedTo:self];
}

-(id)init {
    self = [super init];
    if (self != nil)
    {
        //id rotateAction = [CCEaseElasticInOut actionWithAction:[CCRotateBy actionWithDuration:8.0f angle:360]];
        
        //id scaleUp = [CCScaleTo actionWithDuration:4.0f scale:1.5f];
        //id scaleDown = [CCScaleTo actionWithDuration:4.0f scale:0.5f];
        
        //[viking runAction:[CCRepeatForever actionWithAction:[CCSequence actions:scaleUp,scaleDown,nil]]];
        
        //[viking runAction:[CCRepeatForever actionWithAction:rotateAction]];
        
        //[[GameManager sharedGameManager] playBackgroundTrack:BACKGROUND_TRACK_FLASHCARD];
        //[self displayMainMenu];
        appDelegate = (AppController*) [[UIApplication sharedApplication] delegate];

        CGSize screenSize = [CCDirector sharedDirector].winSize; 
        
        menu_position = CGPointMake(screenSize.width*0.92, screenSize.height*0.15);
        word_sprite_position = ccp(screenSize.width * 0.15f, screenSize.height * 0.6f);
        word_card_startPositon = ccp(screenSize.width * 0.38, screenSize.height * 0.6);
        [self add_menu:menu_position];        

        [self init_wordPuzzle];
     
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
    }
    return self;
}

-(void) init_wordPuzzle
{
    [self add_background];
    [self add_wordSprite:word_sprite_position];        
    [self add_wordCards:[appDelegate.alphabet_words objectAtIndex:current_word_index] position:word_card_startPositon];        
    [self add_alphabet];

}
-(void) add_background
{
    CGSize screenSize = [CCDirector sharedDirector].winSize; 

    self.background = [CCSprite spriteWithFile:@"smileABC_game_bg1.png"];
    
    [self.background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
    self.background.rotation = 0;
    [self addChild:self.background];
    
    id fadeIn = [CCFadeIn actionWithDuration:1];
    [self.background runAction:fadeIn];

}

-(void) add_wordSprite:(CGPoint)position
{
    NSString *cur_word_string = [appDelegate.alphabet_words objectAtIndex:current_word_index];
    NSString *cur_word_spriteName = [NSString stringWithFormat:@"%@.png", cur_word_string];
    self.word_sprite = [CCSprite spriteWithFile:cur_word_spriteName];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        //for ipad
    }
    else
    {
        if (CC_CONTENT_SCALE_FACTOR() == 2)
        {
            self.word_sprite.scale = 0.3;
            
        }
        else
        {
            self.word_sprite.scale = 0.15;
            
        }
    }


    [self addChild:word_sprite];
    
    CGSize screenSize = [CCDirector sharedDirector].winSize; 

    NSInteger randomX = arc4random()%(int)(screenSize.width);
    NSInteger randomY = arc4random()%(int)(screenSize.height);
    self.word_sprite.position = ccp(randomX, randomY);
    NSInteger randomJumpCount = arc4random()%5;

    //id move = [CCMoveTo actionWithDuration:1 position:position];
    id jump = [CCJumpTo actionWithDuration:1 position:position height:50 jumps:randomJumpCount];
	//id move_back = [move reverse];
    
	//id move_ease_in = [CCEaseIn actionWithAction:[[move copy] autorelease] rate:10.5f];

    [self.word_sprite runAction:jump];

}

-(void) add_menu:(CGPoint)position
{
    
//     CCLabelTTF *play_next = [[CCLabelTTF alloc] initWithString:@"next" fontName:MENU_FONT_NAME fontSize:MENU_FONT_SIZE];
//     play_next.color = ccc3(0, 0, 0);
//     CCMenuItemLabel *play_nextLabel = [CCMenuItemLabel
//     itemWithLabel:play_next target:self
//     selector:@selector(playScene:)];
//     [play_nextLabel setTag:MENU_NEXT_TAG];
//     [play_next release];
//     
//     CCLabelTTF *play_previous = [[CCLabelTTF alloc] initWithString:@"previous" fontName:MENU_FONT_NAME fontSize:MENU_FONT_SIZE];
//     play_previous.color = ccc3(0xff, 0xff, 0xcc);
//     CCMenuItemLabel *play_previousLabel = [CCMenuItemLabel
//     itemWithLabel:play_previous target:self
//     selector:@selector(playScene:)];
//     [play_previousLabel setTag:MENU_PREVIOUS_TAG];
//     [play_previous release];
    
    CCMenuItemImage *preButton = [CCMenuItemImage
                                          itemWithNormalImage:@"previousGameCard.png" selectedImage:nil disabledImage:nil target:self selector:@selector(playScene:)];
    CCMenuItemImage *nextButton = [CCMenuItemImage
                                           itemWithNormalImage:@"nextGameCard.png" selectedImage:nil disabledImage:nil target:self selector:@selector(playScene:)];
    [preButton setTag:MENU_PREVIOUS_TAG];
    [nextButton setTag:MENU_NEXT_TAG];

    CCMenu *changeMenu = [CCMenu menuWithItems:nextButton,preButton, nil];
    [changeMenu alignItemsVerticallyWithPadding:0];
    changeMenu.position = position;

     [self addChild:changeMenu z:50];
    
}


-(void)playScene:(CCMenuItem *)menu_image
{

    [self clear_all];
    if (menu_image.tag == MENU_NEXT_TAG)
    {
        //[self scheduleOnce:@selector(play_next) delay:1];
        [self increase_word_index];
    }
    else if (menu_image.tag == MENU_PREVIOUS_TAG)
    {
        //[self scheduleOnce:@selector(play_previous) delay:1];
        [self decrease_word_index];
    }
    [self init_wordPuzzle];

    
}

-(void) clear_all
{
    //[self removeAllChildrenWithCleanup:YES];
    for (WordCard *cur_card in self.wordCards)
    {
        [cur_card removeFromParentAndCleanup:YES];
    }
    for (WordLetter *cur_letter in self.alphabet)
    {
        [cur_letter removeFromParentAndCleanup:YES];
    }
    [self.wordCards removeAllObjects];
    [self.alphabet removeAllObjects];
    [self.word_sprite removeFromParentAndCleanup:YES];

    [self.background removeFromParentAndCleanup:YES];
    selCharacter = nil;
}

-(void) add_wordCards:(NSString *)word position:(CGPoint)position
{
    NSInteger randomIndex = arc4random()%(int)[word length];

    for (int i = 0; i < [word length]; i++)
    {
        NSString *subString = [word substringWithRange:NSMakeRange(i, 1)];
        WordCard *card = [[WordCard alloc] initWithFile:@"word_bg.png" info:subString];
        card.opacity = 255*0.5;

        if (i == randomIndex)
        {
            card.cardInfo.visible = NO;
        }
        card.position = CGPointMake((position.x + i*WORD_CARD_WIDTH), position.y);
        [self.wordCards addObject:card];
        [self add_WordCard:card];
        [card release];
    }
}

-(void) add_alphabet
{
    CGSize screenSize = [CCDirector sharedDirector].winSize; 
    WordLetter *letter_label;
    CGFloat global_x_shift = 10.0;
    CGFloat global_y_shift = 20.0;
    for (int i = 0; i < [appDelegate.alphabet count]; i++)
    {
        NSString *letter = [appDelegate.alphabet objectAtIndex:i];
        letter_label = [[WordLetter alloc] initWithString:letter];
        CGFloat x = (screenSize.width)/16 * (i%13 + 1);
        CGFloat y = screenSize.height * 0.1 * (3 - (i/13 + 1));
        letter_label.position = CGPointMake( x-global_x_shift,  y+global_y_shift);
        [self.alphabet addObject:letter_label];
        [self addChild:letter_label];
        [letter_label release];
        
    }

}
#pragma mark - word effects

-(void) playLetterSound:(id)sender letter:(NSString *)letter_name
{
    [[GameManager sharedGameManager] playSoundEffect:letter_name];

}

-(id) letterAction:(NSString *)letter_name
{
    id action_speak = [CCCallFuncND actionWithTarget:self selector:@selector(playLetterSound:letter:) data:(void *)letter_name];
    
    id actionScaleTo = [CCScaleTo actionWithDuration:0.5  scale: 2];
    id actionScaleToBack = [CCScaleTo actionWithDuration:0.5  scale: 1];
    
    id sel_actions = [CCSequence actions:action_speak, actionScaleTo, actionScaleToBack, nil];
    return sel_actions;

}
#pragma mark - touch

- (void)selectSpriteForTouch:(CGPoint)touchLocation
{
    WordLetter * newCharacter = nil;
    for (WordLetter *character in self.alphabet) {
        if (CGRectContainsPoint(character.boundingBox, touchLocation))
        { 
            newCharacter = character;
            sel_orig_positon = character.position;
            
            id sel_actions = [self letterAction:newCharacter.string];
            [newCharacter runAction:sel_actions];
            break;
        }
    } 
    if (newCharacter != selCharacter)
    {
        //[selCharacter stopAllActions];
        [selCharacter runAction:[CCRotateTo actionWithDuration:0.1 angle:0]];
        CCRotateTo * rotLeft = [CCRotateBy actionWithDuration:0.1 angle:-4.0];
        CCRotateTo * rotCenter = [CCRotateBy actionWithDuration:0.1 angle:0.0];
        CCRotateTo * rotRight = [CCRotateBy actionWithDuration:0.1 angle:4.0];
        CCSequence * rotSeq = [CCSequence actions:rotLeft, rotCenter, rotRight, rotCenter, nil];
        [newCharacter runAction:[CCRepeatForever actionWithAction:rotSeq]]; 
        selCharacter = newCharacter;
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{ 
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation]; 
    return TRUE; 
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{ 
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation); 
    [self panForTranslation:translation]; 
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    //CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    //CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    //oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    //oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    //CGPoint translation = ccpSub(touchLocation, oldTouchLocation); 
    //[self panForTranslation:translation]; 
    if (selCharacter)
    {
        selCharacter.position = sel_orig_positon;
    }

}

-(bool) select_right_letter:(WordLetter *)word_letter withCard:(WordCard *)word_card 
{
    return (CGRectContainsPoint(word_card.boundingBox, word_letter.position)
            &&[word_letter.string isEqualToString:word_card.cardInfo.string]
            &&(!word_card.cardInfo.visible));
}

-(bool) wordPuzzleComplete
{
    bool isComplete = YES;
    for (WordCard *cur_card in self.wordCards)
    {
        isComplete = isComplete && cur_card.cardInfo.visible;
    }
    return isComplete;
}

-(void) wordPuzzleCompleteAnimation
{
    //id action = [CCSequence actions: action_speak, [CCDelayTime actionWithDuration:2], action_speak1, t1, nil];

    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

    //[selCharacter runAction:action];
    NSMutableArray *seqActionArray = [NSMutableArray array];
    NSMutableArray *spawnActionArray = [NSMutableArray array];
    id actionDelay = [CCDelayTime actionWithDuration:0.7];
    [seqActionArray addObject:actionDelay];
    for (WordCard *cur_card in self.wordCards)
    {
        id action_speak = [CCCallFuncND actionWithTarget:self selector:@selector(playLetterSound:letter:) data:cur_card.cardInfo.string];
        id actionScaleTo = [CCScaleTo actionWithDuration:0.5  scale: 2];
        id actionScaleBack = [CCScaleTo actionWithDuration:0.5  scale: 1];
        id action_scale = [CCSequence actions:actionScaleTo, actionScaleBack, nil];
        id card_action_sequence = [CCSequence actions:action_speak, action_scale, actionDelay, nil];
        id cur_card_action = [CCTargetedAction actionWithTarget:cur_card.cardInfo action:card_action_sequence];
        [seqActionArray addObject:cur_card_action];
        id cur_card_action2 = [CCTargetedAction actionWithTarget:cur_card.cardInfo action:action_scale];
        [spawnActionArray addObject:cur_card_action2];

    }

    id seq_actions = [CCSequence actionWithArray:seqActionArray];
    
    NSString *cur_word_string = [appDelegate.alphabet_words objectAtIndex:current_word_index];
    id action_speak_word = [CCCallFuncND actionWithTarget:self selector:@selector(playLetterSound:letter:) data:cur_word_string];
    [spawnActionArray addObject:action_speak_word];
    id spawn_actions = [CCSpawn actionWithArray:spawnActionArray];

    [selCharacter runAction:[CCSequence actions:seq_actions,actionDelay,spawn_actions, nil]];
    
    [pool release];
    
    //play next card
    NSTimeInterval delayTime = cur_word_string.length * 2.0 + 2.5;
    [self performSelector:@selector(playNextCard) withObject:self afterDelay:delayTime];


}
-(void)playNextCard
{
    [self clear_all];
    [self increase_word_index];
    [self init_wordPuzzle];
}

- (void)panForTranslation:(CGPoint)translation
{ 
    if (selCharacter)
    {
        CGPoint newPos = ccpAdd(selCharacter.position, translation);
        for (WordCard *cur_card in self.wordCards)
        {
            if ([self select_right_letter:selCharacter withCard:cur_card])
            {
                cur_card.cardInfo.visible = YES;
                if ([self wordPuzzleComplete])
                {
                    [self wordPuzzleCompleteAnimation];
                    return;
                }
            }
        }
        
        selCharacter.position = newPos;
    }
}

-(void)dealloc
{
    [alphabet release];
    [wordCards release];
    [word_sprite release];
    [background release];
    [super dealloc];
}

@end
