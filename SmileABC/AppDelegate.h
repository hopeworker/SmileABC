//
//  AppDelegate.h
//  SmileABC
//
//  Created by xiongwei on 13-1-28.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "cocos2d.h"
@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;
	
	CCDirectorIOS	*director_;							// weak ref
    NSArray *alphabet;
    NSArray *alphabet_words;
    SystemSoundID shortSound;
    AVAudioPlayer *thePlayer;

}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;
@property (nonatomic, retain) NSArray *alphabet;
@property (nonatomic, retain) NSArray *alphabet_words;
@property (nonatomic, retain) AVAudioPlayer *thePlayer;

-(void) playSound:(NSString *)sound_name;

@end
