//
//  FlashCardScene.m
//  SmileABC
//
//  Created by xiongwei on 13-2-4.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "FlashCardScene.h"


@implementation FlashCardScene
-(id)init {
    self = [super init];
    if (self != nil) {
       FlashCardLayer *flashCardLayer = [FlashCardLayer node];
        [self addChild:flashCardLayer];
    }
    return self;
}

@end
