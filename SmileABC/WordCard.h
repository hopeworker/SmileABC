//
//  WordCard.h
//  SmileABC
//
//  Created by xiongwei on 13-2-4.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define CARD_FONT_NAME @"Helvetica"
#define CARD_FONT_SIZE 40
#define CARD_LETTER_COLOR ccc3(0, 0, 255);

@interface WordCard : CCSprite
{
    CCLabelTTF *cardInfo;
    
}
@property (nonatomic, retain) CCLabelTTF *cardInfo;

-(id) initWithFile:(NSString *)filename info:(NSString *)info;
-(id) initWithSpriteFrameName:(NSString *)framename info:(NSString *)info;
-(void) addedTo:(id)target;
-(void) removeFromParentAndCleanup:(BOOL)cleanup;

@end


@interface WordLetter : CCLabelTTF
{
    //bool is_fixed;
    
}
//@property (nonatomic, assign) bool is_fixed;
-(id) initWithString:(NSString *)text fontName:(NSString *)fontName fontSize:(CGFloat)fontSize;
-(id) initWithString:(NSString *)text;


@end
