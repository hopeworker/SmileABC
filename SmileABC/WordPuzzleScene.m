//
//  WordPuzzleScene.m
//  SmileABC
//
//  Created by xiongwei on 13-2-4.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "WordPuzzleScene.h"


@implementation WordPuzzleScene
-(id)init {
    self = [super init];
    if (self != nil) {
      WordPuzzleLayer *wordPuzzleLayer = [WordPuzzleLayer node];
        [self addChild:wordPuzzleLayer];
    }
    return self;
}

@end
