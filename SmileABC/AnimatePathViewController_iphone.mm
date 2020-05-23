//
//  AnimatePathViewController_iphone.m
//  SmileABC
//
//  Created by xiongwei on 13-2-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "AnimatePathViewController_iphone.h"

#define ANIMATE_DURATION_TIME 7.0
#define LETTER_BUTTON_WIDTH 44.0

@interface AnimatePathViewController_iphone ()

@end

@implementation AnimatePathViewController_iphone
@synthesize homeButton;
@synthesize uppercaseButton;
@synthesize lowercaseButton;
@synthesize autoAnimateView;
@synthesize lettersButtonBgView;
@synthesize pathLayer;
@synthesize penLayer;
@synthesize paintImageView;
//@synthesize paintBgView;
@synthesize backgroundImageView;
@synthesize letterButtonArray;
@synthesize pathDic;
@synthesize appDelegate;

-(NSDictionary *)pathDic
{
    if (pathDic == nil)
    {

        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"lettersPath" ofType:@"plist"];
        pathDic = [[NSDictionary alloc] initWithContentsOfFile:filePath];

    }
    return pathDic;
}

-(NSMutableArray *)letterButtonArray
{
    if (letterButtonArray == nil)
    {
        letterButtonArray = [[NSMutableArray alloc] init];
    }
    return letterButtonArray;
}
-(void)dealloc
{
    [letterButtonArray release];
    [pathDic release];
    [super dealloc];
}

#pragma mark - UIViewController life cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)characterSwipeToAnimation:(UIView *)animate_target duration:(NSTimeInterval)duration angle:(CGFloat)angle
{
    //UIView *animateView = self.letterCharacterImageView;
    CGAffineTransform transform = animate_target.transform;
    
    UIViewAnimationOptions options = UIViewAnimationOptionAllowUserInteraction;
    [UIView animateWithDuration:duration delay:0 options:options animations:
     ^{
         animate_target.transform = CGAffineTransformRotate(CGAffineTransformScale(transform, 1, 1), angle);
     }completion:^(BOOL finished)
     {
         [self characterSwipeBackAnimation:animate_target duration:duration angle:angle];

     }];

}

- (void)characterSwipeBackAnimation:(UIView *)animate_target duration:(NSTimeInterval)duration angle:(CGFloat)angle
{
    CGAffineTransform transform = animate_target.transform;
    
    UIViewAnimationOptions options = UIViewAnimationOptionAllowUserInteraction;
    [UIView animateWithDuration:duration delay:0 options:options animations:
     ^{
         animate_target.transform = CGAffineTransformRotate(CGAffineTransformScale(transform, 1, 1), -angle);
     }completion:^(BOOL finished)
     {
         [self characterSwipeToAnimation:animate_target duration:duration angle:angle];
         
     }];
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.backgroundImageView.image = [UIImage imageNamed:@"smileABC_writeLetter_bg.png"];
    appDelegate = (AppController*) [[UIApplication sharedApplication] delegate];

    //init animation settings
    self.autoAnimateView.backgroundColor = [UIColor clearColor];

    [self.homeButton setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];

    //init the letters button
    self.lettersButtonBgView.backgroundColor = [UIColor clearColor];
    self.lettersButtonBgView.alpha = 0.8;
    letterButtonArray = [[NSMutableArray alloc] init];
    
    CGFloat orig_position_x = self.lettersButtonBgView.frame.origin.x + LETTER_BUTTON_WIDTH/2;
    CGFloat orig_position_y = self.lettersButtonBgView.frame.origin.y + LETTER_BUTTON_WIDTH/2;
    //CGFloat bg_width = self.lettersButtonBgView.frame.size.width;
    //CGFloat bg_height = self.lettersButtonBgView.frame.size.height;
    CGFloat cur_position_x = orig_position_x;
    CGFloat cur_position_y = orig_position_y;
    for (int i = 0; i < [appDelegate.alphabet count]; i++)
    {
        UIButton *letterBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, LETTER_BUTTON_WIDTH, LETTER_BUTTON_WIDTH)];
        letterBtn.titleLabel.textAlignment = UITextAlignmentCenter;
        
        NSString *cur_Letter = [appDelegate.alphabet objectAtIndex:i];
        cur_Letter = cur_Letter.uppercaseString;
        [letterBtn setTitle:cur_Letter forState:UIControlStateNormal];
        letterBtn.titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:24.0];
        [letterBtn addTarget:self action:@selector(letterBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [letterBtn setTag:i];
        cur_position_x = orig_position_x + (i%5)*LETTER_BUTTON_WIDTH;
        cur_position_y = orig_position_y + (i/5)*LETTER_BUTTON_WIDTH;
        letterBtn.center = CGPointMake(cur_position_x, cur_position_y);
        [self.view addSubview:letterBtn];
        NSTimeInterval durationTime = i * 0.01 + 0.2;
        CGFloat angle = M_PI/18;
        [self characterSwipeToAnimation:letterBtn duration:durationTime angle:angle];
        [self.letterButtonArray addObject:letterBtn];
        [letterBtn release];

    }
    
    //init the user paint view, at the beginning it is hidden.
    //paint view
    //UIImage *sharpImage = [UIImage imageNamed:@"a.jpg"];
    //self.paintBgView.image = sharpImage;
	UIImage * blurImage = [UIImage imageNamed:@"word_bg.png"];
    CGRect maskViewRect = self.autoAnimateView.frame;
    paintImageView = [[[ImageMaskView alloc] initWithFrame:maskViewRect image:blurImage] autorelease];
    paintImageView.alpha = 0.8;
    paintImageView.radius = 1;
    paintImageView.hidden = YES;
    [self.view addSubview:paintImageView];
    
    [self setupDrawingLayer:self.autoAnimateView forLetter:@"A"];
    [self startAnimation];


}

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

#pragma mark - animate path

-(CGRect) rectMutiply:(CGRect)orig_rect ratio:(CGFloat)f_ratio
{
    return CGRectMake(orig_rect.origin.x * f_ratio, orig_rect.origin.y * f_ratio, orig_rect.size.width * f_ratio, orig_rect.size.height * f_ratio);
}

- (void) setupDrawingLayer:(UIView *)coverView forLetter:(NSString *)letter
{
    if (self.pathLayer != nil) {
        [self.penLayer removeFromSuperlayer];
        [self.pathLayer removeFromSuperlayer];
        self.pathLayer = nil;
        self.penLayer = nil;
    }
    
    CGRect pathRect = coverView.bounds;
    NSMutableArray * letter_path = [self.pathDic objectForKey:letter];
    if ([letter_path count] == 0)
    {
        NSLog(@"no path for the letter %@", letter);
        return;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSMutableArray *segment in letter_path)
    {
        CGPoint cur_point;
        CGPoint previous_point;
        for (int i = 0; i < [segment count]; i++)
        {
            cur_point = CGPointFromString([segment objectAtIndex:i]);
            cur_point = fromUItoQuartz(cur_point, CGSizeMake(100, 100));
            //points in plist is assume the rect size (100, 100)
            CGFloat x_scale = pathRect.size.width/100;
            CGFloat y_scale = pathRect.size.height/100;
            cur_point = CGPointMake(cur_point.x * x_scale, cur_point.y * y_scale);
            if (i == 0)
            {
                [path moveToPoint:cur_point];

            }
            else
            {
                [path addQuadCurveToPoint:cur_point controlPoint:previous_point];

            }
            previous_point = cur_point;
        }
    }
        
    CAShapeLayer *tmp_pathLayer = [CAShapeLayer layer];
    tmp_pathLayer.frame = CGRectMake(0, 0, coverView.bounds.size.width, coverView.bounds.size.height);
    tmp_pathLayer.bounds = coverView.bounds;

    tmp_pathLayer.geometryFlipped = YES;
    tmp_pathLayer.path = path.CGPath;
    tmp_pathLayer.strokeColor = [[UIColor colorWithRed:0xff/256.0 green:0xff/256.0 blue:0x66/256.0 alpha:1.0] CGColor];
    tmp_pathLayer.fillColor = nil;
    tmp_pathLayer.lineWidth = 8.0f;
    tmp_pathLayer.lineCap = kCALineCapRound;
    tmp_pathLayer.lineJoin = kCALineJoinRound;
    self.pathLayer = tmp_pathLayer;

    [coverView.layer addSublayer:self.pathLayer];
    
    UIImage *penImage = [UIImage imageNamed:@"animationPen.png"];
    CALayer *tmp_penLayer = [CALayer layer];
    tmp_penLayer.contents = (id)penImage.CGImage;
    tmp_penLayer.anchorPoint = CGPointZero;
    tmp_penLayer.frame = CGRectMake(0.0f, 0.0f, penImage.size.width/3, penImage.size.height/3);
    tmp_penLayer.anchorPoint = CGPointMake(0, 1.0);
    [pathLayer addSublayer:tmp_penLayer];
    
    self.penLayer = tmp_penLayer;
}

- (void) startAnimation
{
    [self.pathLayer removeAllAnimations];
    [self.penLayer removeAllAnimations];
    
    self.penLayer.hidden = NO;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = ANIMATE_DURATION_TIME;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    CAKeyframeAnimation *penAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    penAnimation.duration = ANIMATE_DURATION_TIME;
    penAnimation.path = self.pathLayer.path;
    penAnimation.calculationMode = kCAAnimationPaced;
    penAnimation.delegate = self;
    [self.penLayer addAnimation:penAnimation forKey:@"position"];
    self.penLayer.position = CGPointMake(0,0);
}

#pragma mark - letters path


- (IBAction)backHome:(UIButton *)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)letterBtnClicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    NSString *cur_Letter = btn.titleLabel.text;
    [appDelegate playSound:cur_Letter.lowercaseString];

    [self setupDrawingLayer:self.autoAnimateView forLetter:cur_Letter];
    [self startAnimation];
    
}
- (IBAction)uppercaseBtnClicked:(UIButton *)sender
{
    for (int i = 0; i < [self.letterButtonArray count]; i++)
    {
        UIButton *letterBtn =  [self.letterButtonArray objectAtIndex:i];       
        NSString *cur_Letter = [appDelegate.alphabet objectAtIndex:i];
        cur_Letter = cur_Letter.uppercaseString;
        [letterBtn setTitle:cur_Letter forState:UIControlStateNormal];
    }
}

- (IBAction)lowercaseBtnClicked:(UIButton *)sender
{
    for (int i = 0; i < [self.letterButtonArray count]; i++)
    {
        UIButton *letterBtn =  [self.letterButtonArray objectAtIndex:i];       
        NSString *cur_Letter = [appDelegate.alphabet objectAtIndex:i];
        cur_Letter = cur_Letter.lowercaseString;
        [letterBtn setTitle:cur_Letter forState:UIControlStateNormal];
    }
}

@end
