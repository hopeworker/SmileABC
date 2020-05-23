//
//  FlashCardLayer.m
//  SmileABC
//
//  Created by xiongwei on 13-2-4.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "FlashCardLayer.h"


@implementation FlashCardLayer

-(id)init {
    self = [super init];
    if (self != nil) {
        CGSize screenSize = [CCDirector sharedDirector].winSize; 
        
        CCSprite *background = 
        [CCSprite spriteWithFile:@"a.jpg"];
        [background setPosition:ccp(screenSize.width/2, 
                                    screenSize.height/2)];
        [self addChild:background];
        //[self displayMainMenu];
        
        CCSprite *viking = 
        [CCSprite spriteWithFile:@"b.jpg"];
        [viking setPosition:ccp(screenSize.width * 0.35f, 
                                screenSize.height * 0.45f)];
        [self addChild:viking];
        
        id rotateAction = [CCEaseElasticInOut actionWithAction:
                           [CCRotateBy actionWithDuration:8.0f 
                                                    angle:360]];
        
        id scaleUp = [CCScaleTo actionWithDuration:4.0f scale:1.5f];
        id scaleDown = [CCScaleTo actionWithDuration:4.0f scale:0.5f];
        
        [viking runAction:[CCRepeatForever actionWithAction:
                           [CCSequence 
                            actions:scaleUp,scaleDown,nil]]];
        
        [viking runAction:
         [CCRepeatForever actionWithAction:rotateAction]];
        
        //[[GameManager sharedGameManager] playBackgroundTrack:BACKGROUND_TRACK_FLASHCARD];
        
        
        
        
    }
    return self;
}

@end
