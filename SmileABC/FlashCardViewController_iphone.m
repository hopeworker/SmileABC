//
//  FlashCardViewController_iphone.m
//  SmileABC
//
//  Created by xiongwei on 13-1-29.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "FlashCardViewController_iphone.h"

@interface FlashCardViewController_iphone ()

@end

@implementation FlashCardViewController_iphone
@synthesize bgImageView;
@synthesize letterCharacterImageView;
@synthesize letterCharacterWordLabel;
@synthesize uppercaseLetterImageView;
@synthesize lowercaseLetterImageView;
@synthesize voiceButton;
@synthesize homeButton;
@synthesize cur_letter_index;
@synthesize nextButton;
@synthesize previousButton;
//@synthesize player;
@synthesize tapGesture;
@synthesize appDelegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) increase_cur_letter_index
{
    self.cur_letter_index = (self.cur_letter_index + 1)%[appDelegate.alphabet count];
}

-(void) decrease_cur_letter_index
{
    if (self.cur_letter_index == 0)
    {
        self.cur_letter_index = [appDelegate.alphabet count];
    }
    self.cur_letter_index = (self.cur_letter_index - 1)%[appDelegate.alphabet count];
}


-(void) add_character
{
    NSString *cur_Letter = [appDelegate.alphabet objectAtIndex:self.cur_letter_index];
    [appDelegate playSound:cur_Letter];
    
    NSString *uppercaseLetter = cur_Letter.uppercaseString;
    NSString *uppercaseLetterImageName = [NSString stringWithFormat:@"letter__%@.png", uppercaseLetter];
    self.uppercaseLetterImageView.image = [UIImage imageNamed:uppercaseLetterImageName];
    self.uppercaseLetterImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    NSString *lowercaseLetterImageName = [NSString stringWithFormat:@"letter_%@.png", cur_Letter];
    self.lowercaseLetterImageView.image = [UIImage imageNamed:lowercaseLetterImageName];
    self.lowercaseLetterImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.letterCharacterImageView.image = [UIImage imageNamed:[appDelegate.alphabet_words objectAtIndex:self.cur_letter_index]];
    self.letterCharacterImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.letterCharacterWordLabel.text = [appDelegate.alphabet_words objectAtIndex:self.cur_letter_index];
    self.letterCharacterWordLabel.textColor = [UIColor colorWithRed:0x33/256.0 green:0x66/256.0 blue:0x33/256.0 alpha:1];
    self.letterCharacterWordLabel.font = [UIFont fontWithName:@"Arial" size:45.0];

}

-(void) upDownAnimateForever:(NSString *)animate_name target:(UIView *)animate_target duration:(NSTimeInterval)duration height:(CGFloat)height
{
    [UIView beginAnimations:animate_name context:animate_target];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatCount:100000];
    CGFloat animateEndY = animate_target.frame.origin.y + height;
    animate_target.frame = CGRectMake(animate_target.frame.origin.x, animateEndY, animate_target.frame.size.width, animate_target.frame.size.height);
    [UIView commitAnimations];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *bgImage = [UIImage imageNamed:@"smileABC_card1_bg.png"];
    self.bgImageView.image = bgImage;
    appDelegate = (AppController*) [[UIApplication sharedApplication] delegate];
    
    [self add_character];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    self.letterCharacterImageView.userInteractionEnabled = YES;
    self.uppercaseLetterImageView.userInteractionEnabled = YES;
    self.lowercaseLetterImageView.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;
    
    [self upDownAnimateForever:@"uppercaseLetterAnimate" target:self.uppercaseLetterImageView duration:3 height:20];
    [self upDownAnimateForever:@"lowercaseLetterAnimate" target:self.lowercaseLetterImageView duration:3 height:20];
    [self.nextButton setImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [self.previousButton setImage:[UIImage imageNamed:@"previous.png"] forState:UIControlStateNormal];
    [self.homeButton setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UIControl class]]) {
        // we touched a button, slider, or other UIControl
        return NO; // ignore the touch
    }
    return YES; // handle the touch
}

-(void)swipeAnimation:(UIView *)animateView
{
    //UIView *animateView = self.letterCharacterImageView;
    CGAffineTransform transform = animateView.transform;
    NSTimeInterval durationTime = 0.2;
    CGFloat angle = M_PI/18;
    UIViewAnimationOptions options = UIViewAnimationOptionCurveLinear;
        [UIView animateWithDuration:durationTime delay:0 options:options animations:
         ^{
             animateView.transform = CGAffineTransformRotate(CGAffineTransformScale(transform, 1, 1), angle);
         }completion:^(BOOL finished)
         {
             if (finished)
             {
                 [UIView animateWithDuration:durationTime delay:0 options:options animations:^{
                     animateView.transform = CGAffineTransformRotate(CGAffineTransformScale(transform, 1, 1), 0);
                 } completion:^(BOOL finished)
                  {
                      if (finished)
                      {
                          [UIView animateWithDuration:durationTime delay:0 options:options animations:^{
                              animateView.transform = CGAffineTransformRotate(CGAffineTransformScale(transform, 1, 1), -angle);
                          } completion:^(BOOL finished)
                           {
                               if (finished)
                               {
                                   [UIView animateWithDuration:durationTime delay:0 options:options animations:^{
                                       animateView.transform = CGAffineTransformRotate(CGAffineTransformScale(transform, 1, 1), 0);
                                   } completion:^(BOOL finished)
                                    {
                                        
                                    }];
                                   
                               }
                           }];
                          
                      }
                      
                  }];
             }
         }];


}
//*/
 - (void)tap:(UITapGestureRecognizer *)gesture
 {
     CGPoint tapLocation = [gesture locationInView:self.view];
     if (CGRectContainsPoint(self.letterCharacterImageView.frame, tapLocation))
     {
//         UIImage *elephent1 = [UIImage imageNamed:@"ant.png"];
//         UIImage *elephent2 = [UIImage imageNamed:@"banana.png"];
//         NSArray *elephentArray = [[[NSArray alloc] initWithObjects: elephent1, elephent2, nil] autorelease];
//         
//         self.letterCharacterImageView.animationImages = elephentArray;
//         self.letterCharacterImageView.animationDuration = 1.0;
//         self.letterCharacterImageView.animationRepeatCount = 1;
//         [self.letterCharacterImageView startAnimating];
         //if (self.letterCharacterImageView.isAnimating)
         //{
             //[self.letterCharacterImageView stopAnimating];
         //}

         [self swipeAnimation:self.letterCharacterImageView];
         NSString *cur_word = [appDelegate.alphabet_words objectAtIndex:self.cur_letter_index];
         [appDelegate playSound:cur_word];


     }
     if (CGRectContainsPoint(self.uppercaseLetterImageView.frame, tapLocation))
     {         
         [self swipeAnimation:self.uppercaseLetterImageView];
         NSString *cur_Letter = [appDelegate.alphabet objectAtIndex:self.cur_letter_index];
         [appDelegate playSound:cur_Letter];

     }
     if (CGRectContainsPoint(self.lowercaseLetterImageView.frame, tapLocation))
     {         
         [self swipeAnimation:self.lowercaseLetterImageView];
         NSString *cur_Letter = [appDelegate.alphabet objectAtIndex:self.cur_letter_index];
         [appDelegate playSound:cur_Letter];

     }

 }
 //*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}
- (IBAction)backHome:(UIButton *)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
- (IBAction)nextLetter:(UIButton *)sender
{
    [self increase_cur_letter_index];
    [self add_character];
}
- (IBAction)previousButton:(UIButton *)sender
{
    [self decrease_cur_letter_index];
    [self add_character];
}

-(void)dealloc
{
    [tapGesture release];
    [super dealloc];
}

@end
