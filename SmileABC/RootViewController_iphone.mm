//
//  RootViewController_iphone.m
//  SmileABC
//
//  Created by xiongwei on 13-1-29.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController_iphone.h"
#import "GameManager.h"
@interface RootViewController_iphone ()

@end

@implementation RootViewController_iphone
@synthesize director_;
@synthesize homeButton;
@synthesize introduceImageView;
@synthesize tapGesture;
@synthesize introduceLabel;

-(void) SetupCocos2D
{
    // Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
	CCGLView *glView = [CCGLView viewWithFrame:[self.view bounds]
								   pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
								   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];
    
	// Enable multiple touches
	[glView setMultipleTouchEnabled:YES];
    
	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];
	
	director_.wantsFullScreenLayout = YES;
	
	// Display FSP and SPF
	[director_ setDisplayStats:NO];
	
	// set FPS at 60
	[director_ setAnimationInterval:1.0/60];
	
	// attach the openglView to the director
	[director_ setView:glView];
	
    [self.view insertSubview:glView atIndex:0];
    
	// for rotation and other messages
	[director_ setDelegate:self];
	
	// 2D projection
	[director_ setProjection:kCCDirectorProjection2D];
	//	[director setProjection:kCCDirectorProjection3D];
	
	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director_ enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
	// On iPad     : "-ipad", "-hd"
	// On iPhone HD: "-hd"
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"
	
	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
	
	// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
    //[director_ runWithScene: [IntroLayer scene]]; 
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [director_ resume];
    [director_ startAnimation];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //[director_ runWithScene: [IntroLayer scene]]; 
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    self.introduceImageView.userInteractionEnabled = YES;
    UIImage *introduce1 = [UIImage imageNamed:@"SmileABC_game_introduce1.png"];
	UIImage *introduce2 = [UIImage imageNamed:@"SmileABC_game_introduce2.png"];
	UIImage *introduce3 = [UIImage imageNamed:@"SmileABC_game_introduce3.png"];
	NSArray *introduceArray = [[[NSArray alloc] initWithObjects: introduce1, introduce2, introduce3, nil] autorelease];
	
	self.introduceImageView.animationImages = introduceArray;
	self.introduceImageView.animationDuration = 3.0;
	[self.introduceImageView startAnimating];

    [self.introduceImageView addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"])
    { 
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"]; 
        
    }
    else
    {
        [self.introduceImageView removeFromSuperview];
        [self.introduceLabel removeFromSuperview];
        [self SetupCocos2D];
        [[GameManager sharedGameManager] setupAudioEngine];
        [[GameManager sharedGameManager] runSceneWithID:kWordPuzzleScene];
        
    }

    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.homeButton setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];

}

- (void)viewDidUnload
{
    [[CCDirector sharedDirector] end];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}
- (IBAction)backHome:(UIButton *)sender
{
    [director_ pause];
    [director_ stopAnimation];

    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissModalViewControllerAnimated:YES];

}
- (void)tap:(UITapGestureRecognizer *)gesture
{
    [self.introduceImageView removeFromSuperview];
    [self.introduceLabel removeFromSuperview];
    [self SetupCocos2D];
    [[GameManager sharedGameManager] setupAudioEngine];
    [[GameManager sharedGameManager] runSceneWithID:kWordPuzzleScene];
    
}

@end
