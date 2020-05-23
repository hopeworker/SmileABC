//
//  AppDelegate.mm
//  SmileABC
//
//  Created by xiongwei on 13-1-28.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"

#import "MainViewController_iphone.h"
#import "MainViewController_ipad.h"
@implementation AppController

@synthesize window=window_, navController=navController_, director=director_;
@synthesize alphabet;
@synthesize alphabet_words;
@synthesize thePlayer;

-(AVAudioPlayer *)thePlayer
{
    if (thePlayer == nil)
    {
        NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"YourSmile" ofType:@"mp3"];
        NSURL *musicURL = [[NSURL alloc] initFileURLWithPath:musicFilePath];  
        thePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
        [musicURL release];
    }

    
    [thePlayer prepareToPlay];
    [thePlayer setVolume:0.2];
    thePlayer.numberOfLoops = -1;
    return thePlayer;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Create the main window
	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    alphabet = [[NSArray alloc] initWithObjects:@"a",@"b",@"c",@"d",@"e",
                @"f",@"g",@"h",@"i",@"j",
                @"k",@"l",@"m",@"n",@"o",
                @"p",@"q",@"r",@"s",@"t",
                @"u",@"v",@"w",@"x",@"y",@"z",nil];

    alphabet_words = [[NSArray alloc] initWithObjects:@"ant",@"banana",@"cat",@"dog",@"egg",
                      @"fox",@"grape",@"house",@"insect",@"jeep",
                      @"kite",@"leaf",@"moon",@"nurse",@"orange",
                      @"pig",@"queen",@"rabbit",@"ship",@"tree",
                      @"uncle",@"violin",@"watch",@"Xmas",@"yacht",@"zoo",nil];

    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        MainViewController_iphone *mainViewController = [[MainViewController_iphone alloc] initWithNibName:nil bundle:nil];
        
        navController_ = [[UINavigationController alloc]initWithRootViewController:mainViewController];
        [mainViewController release];
    }
    else
    {
        MainViewController_ipad *mainViewController = [[MainViewController_ipad alloc] initWithNibName:nil bundle:nil];
        
        navController_ = [[UINavigationController alloc]initWithRootViewController:mainViewController];
        [mainViewController release];

    }

	navController_.navigationBarHidden = YES;
	
	// set the Navigation Controller as the root view controller
	//[window_ addSubview:navController_.view];	// Generates flicker.
	[window_ setRootViewController:navController_];
	
	// make main window visible
	[window_ makeKeyAndVisible];
    
    [self.thePlayer play];
	
	return YES;
}

// Supported orientations: Landscape. Customize it for your own needs
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}


// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
		
	[navController_ release];
	
	[window_ release];
	
	[director end];	
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

#pragma -mark play sound
-(void) getSoundID:(NSString *)sound_name
{
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:sound_name ofType:@"wav"];
    if (soundPath)
    {
        NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
        OSStatus err = AudioServicesCreateSystemSoundID((CFURLRef)soundUrl, &shortSound);
        if (err != kAudioServicesNoError)
        {
            NSLog(@"Could not load %@, error code: %ld", soundUrl, err);
        }
    }
}

-(void) playSound:(NSString *)sound_name
{
    [self getSoundID:sound_name];
    AudioServicesPlaySystemSound(shortSound);
}


- (void) dealloc
{
	[window_ release];
	[navController_ release];
	[[CCDirector sharedDirector] end];
    [alphabet_words release];
    [alphabet release];
    if (thePlayer.isPlaying)
    {
        [thePlayer stop];
    }
    [thePlayer release];
	[super dealloc];
}
@end

