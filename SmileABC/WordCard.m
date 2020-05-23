//
//  WordCard.m
//  SmileABC
//
//  Created by xiongwei on 13-2-4.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "WordCard.h"


@implementation WordCard
@synthesize cardInfo;

-(id) initWithFile:(NSString *)filename info:(NSString *)info
{
    if (!(self = [super initWithFile:filename]))
    {
        return self;
    }
    cardInfo = [[CCLabelTTF alloc] initWithString:info fontName:CARD_FONT_NAME fontSize:CARD_FONT_SIZE];
    cardInfo.color = CARD_LETTER_COLOR;
    return self;
    
}
-(id) initWithSpriteFrameName:(NSString *)framename info:(NSString *)info
{
    if (!(self = [super initWithSpriteFrameName:framename]))
    {
        return self;
    }
    cardInfo = [[CCLabelTTF alloc] initWithString:info fontName:CARD_FONT_NAME fontSize:CARD_FONT_SIZE];
    cardInfo.color = CARD_LETTER_COLOR;
    return self;

}

-(void)setPosition:(CGPoint)position
{
    [super setPosition:position];
    cardInfo.position = position;
}


-(void) addedTo:(id)target batchNode:(CCSpriteBatchNode *)target_batchNode
{
    [target_batchNode addChild:self];
    [target addChild:cardInfo];
}

-(void) addedTo:(id)target
{
    [target addChild:self];
    [target addChild:cardInfo];
}

-(void)removeFromParentAndCleanup:(BOOL)cleanup
{
    [super removeFromParentAndCleanup:cleanup];
    [cardInfo removeFromParentAndCleanup:cleanup];
}

- (void) dealloc
{
    [cardInfo release];
    [super dealloc];
}

@end


@implementation WordLetter
//@synthesize is_fixed;

-(id) initWithString:(NSString *)text fontName:(NSString *)fontName fontSize:(CGFloat)fontSize
{
    if (!(self = [super initWithString:text fontName:fontName fontSize:fontSize]))
    {
        return self;
    }
    //is_fixed = NO;
    return self;
}

-(id) initWithString:(NSString *)text
{
    if (!(self = [super initWithString:text fontName:CARD_FONT_NAME fontSize:CARD_FONT_SIZE]))
    {
        return self;
    }
    self.color = CARD_LETTER_COLOR;
    //is_fixed = NO;
    return self;
}


@end

