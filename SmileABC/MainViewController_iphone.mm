//
//  MainViewController_iphone.m
//  SmileABC
//
//  Created by xiongwei on 13-1-28.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MainViewController_iphone.h"

@interface MainViewController_iphone ()

@end

@implementation MainViewController_iphone
@synthesize startGame;
@synthesize flashCard;
@synthesize animatePathCard;
@synthesize mail;
@synthesize rootViewController_iphone;
//@synthesize animateLabel;
@synthesize tapGesture;
//@synthesize animationReverse;
@synthesize bgImageView;
@synthesize animateCharacter1ImageView;
@synthesize animateCharacter2ImageView;
@synthesize animateCharacter3ImageView;

-(RootViewController_iphone *)rootViewController_iphone
{
    if (rootViewController_iphone == nil)
    {
        rootViewController_iphone = [[RootViewController_iphone alloc] initWithNibName:nil bundle:nil];
    }
    return rootViewController_iphone;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    //[self.view.layer an];
    [super viewWillAppear:animated];

}

//-(void)viewWillDisappear:(BOOL)animated
//{
//    [self.view.layer removeAllAnimations];
//    for (UIView *curView in self.view.subviews)
//    {
//        [curView.layer removeAllAnimations];
//    }
//    [super viewWillDisappear:animated];
//}

//the reverse_flag should be the global var.
//example:   global_flag =[self upDownAnimation:targetView name:animation_name g_reverse_flag:global_flag];
//-(bool) upDownAnimation:(UIView *)targetView name:(NSString *)animation_name g_reverse_flag:(bool)reverse_flag
//{
//    [UIView beginAnimations:animation_name context:targetView];
//    [UIView setAnimationDuration:2];
//    CGFloat animateEndY = (reverse_flag) ? targetView.frame.origin.y - 30 : targetView.frame.origin.y + 30;
//    reverse_flag = !reverse_flag;
//    targetView.frame = CGRectMake(targetView.frame.origin.x, animateEndY, targetView.frame.size.width, targetView.frame.size.height);
//    [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
//    [UIView setAnimationDelegate:self];
//    [UIView commitAnimations];
//    return reverse_flag;
//
//}

-(void) scaleAnimateForever:(NSString *)animate_name target:(UIView *)animate_target duration:(NSTimeInterval)duration scale:(CGFloat)scale_rate
{
    CGAffineTransform transform = animate_target.transform;
    //CGFloat angle = M_PI/18;

    [UIView beginAnimations:animate_name context:animate_target];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatCount:100000];
    //CGFloat animateEndY = animate_target.frame.origin.y + height;
    //animate_target.frame = CGRectMake(animate_target.frame.origin.x, animateEndY, animate_target.frame.size.width, animate_target.frame.size.height);
    animate_target.transform = CGAffineTransformRotate(CGAffineTransformScale(transform, scale_rate, scale_rate), 0);
    [UIView commitAnimations];
    
}

-(void) upDownAnimateForever:(NSString *)animate_name target:(UIView *)animate_target duration:(NSTimeInterval)duration height:(CGFloat)height
{
    [UIView beginAnimations:animate_name context:animate_target];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationRepeatAutoreverses:YES];
    //    [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
    [UIView setAnimationRepeatCount:100000];
    CGFloat animateEndY = animate_target.frame.origin.y + height;
    animate_target.frame = CGRectMake(animate_target.frame.origin.x, animateEndY, animate_target.frame.size.width, animate_target.frame.size.height);
    [UIView commitAnimations];
    
}


- (void)characterUpAnimation:(UIView *)animate_target duration:(NSTimeInterval)duration height:(CGFloat)height
{
    [UIView animateWithDuration:duration animations:
                                    ^{
                                        CGFloat animateEndY = animate_target.frame.origin.y + height;
                                        animate_target.frame = CGRectMake(animate_target.frame.origin.x, animateEndY, animate_target.frame.size.width, animate_target.frame.size.height);
                                    }
                                    completion:^(BOOL finished)
                                    {
                                        [self characterDownAnimation:animate_target duration:duration height:height];
                                    }];
}

- (void)characterDownAnimation:(UIView *)animate_target duration:(NSTimeInterval)duration height:(CGFloat)height
{
    [UIView animateWithDuration:duration animations:
                                        ^{
                                            CGFloat animateEndY = animate_target.frame.origin.y - height;
                                            animate_target.frame = CGRectMake(animate_target.frame.origin.x, animateEndY, animate_target.frame.size.width, animate_target.frame.size.height);
                                        }
                                        completion:^(BOOL finished)
                                        {
                                            [self characterUpAnimation:animate_target duration:duration height:height];
                                        }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bgImageView.image = [UIImage imageNamed:@"smileABC_bg.png"];
    self.animateCharacter1ImageView.image = [UIImage imageNamed:@"pig.png"];
    self.animateCharacter1ImageView.contentMode = UIViewContentModeScaleAspectFit;

    self.animateCharacter2ImageView.image = [UIImage imageNamed:@"grape.png"];
    self.animateCharacter2ImageView.contentMode = UIViewContentModeScaleAspectFit;

    self.animateCharacter3ImageView.image = [UIImage imageNamed:@"Xmas.png"];
    self.animateCharacter3ImageView.contentMode = UIViewContentModeScaleAspectFit;

    [self scaleAnimateForever:@"flashcard_animation" target:self.flashCard duration:1 scale:1.05];
    [self scaleAnimateForever:@"writeLetter_animation" target:self.animatePathCard duration:1 scale:1.05];
    [self scaleAnimateForever:@"wordPuzzle_animation" target:self.startGame duration:1 scale:1.05];
    //[self upDownAnimateForever:@"animateCharacter1" target:self.animateCharacter1ImageView duration:3 height:30];
    //[self upDownAnimateForever:@"animateCharacter2" target:self.animateCharacter2ImageView duration:2 height:35];
    //[self upDownAnimateForever:@"animateCharacter3" target:self.animateCharacter3ImageView duration:3 height:30];
    
    [self characterDownAnimation:self.animateCharacter1ImageView duration:5.0 height:20];
    [self characterUpAnimation:self.animateCharacter2ImageView duration:4.0 height:30];
    [self characterDownAnimation:self.animateCharacter3ImageView duration:4.0 height:20];
    
    
}


/*/
- (void)onAnimationComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:@"labelAnimate"])
    {
        UIView *labelView = (UIView *)context;
        self.animationReverse = [self upDownAnimation:labelView name:@"labelAnimate" g_reverse_flag:self.animationReverse];

    }
    if ([animationID isEqualToString:@"labelAnimate2"])
    {
        UIView *labelView = (UIView *)context;
        animationReverse2 = [self upDownAnimation:labelView name:@"labelAnimate2" g_reverse_flag:animationReverse2];
        
    }

}
//*/


- (void)viewDidUnload
{
    [super viewDidUnload];
    //[[CCDirector sharedDirector] end];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)startGame:(UIButton *)sender
{
    //[self.navigationController pushViewController:self.rootViewController_iphone animated:YES];
    [self presentModalViewController:self.rootViewController_iphone animated:YES];

}
- (IBAction)flashCard:(UIButton *)sender
{
    FlashCardViewController_iphone *flashCardViewController = [[FlashCardViewController_iphone alloc] initWithNibName:nil bundle:nil];
    [self presentModalViewController:flashCardViewController animated:YES];
    [flashCardViewController release];

    
}
- (IBAction)animatePath:(UIButton *)sender
{
    AnimatePathViewController_iphone *animatePathViewController = [[AnimatePathViewController_iphone alloc] initWithNibName:nil bundle:nil];
    [self presentModalViewController:animatePathViewController animated:YES];
    [animatePathViewController release];

}
#pragma mark MailComposer delegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;
{
    NSString *message;
    message = nil;
    
    // Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
			break;
		case MFMailComposeResultFailed:
            //message = [NSString stringWithString:@"Mail Failed."];
            message = [[NSString alloc] initWithFormat:@"Mail Failed."];
			break;
		default:
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
    
    if(message != nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Status"
                                                        message:message delegate:nil 
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    [message release];
}

- (IBAction)mailMe:(UIButton *)sender
{
    //mail the text
    if(![MFMailComposeViewController canSendMail]) {
        // can't send mail.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Mail not configured or available." 
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setToRecipients:[NSArray arrayWithObject:@"ahope_2009@163.com"]];
    [picker setSubject:@"a message from Smile ABC"];
    
    // Fill out the email body text
    NSString *sendText = @"hi,nice to meet you!";
    [picker setMessageBody:sendText isHTML:NO];
    [sendText release];
    
    [self presentModalViewController:picker animated:YES];
    [picker release];

}

-(void)dealloc
{
    [rootViewController_iphone release];
    //[animateLabel release];
    //[tapGesture release];
    [super dealloc];
}

@end
