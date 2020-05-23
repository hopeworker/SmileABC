//
//  AnimatePathViewController_iphone.h
//  SmileABC
//
//  Created by xiongwei on 13-2-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ImageMaskView.h"
#import "AppDelegate.h"

//#import "PointTransforms.h"

@interface AnimatePathViewController_iphone : UIViewController
{
    UIButton *homeButton;
    UIButton *uppercaseButton;
    UIButton *lowercaseButton;
    UIView *lettersButtonBgView;

    UIView *autoAnimateView;
    CAShapeLayer *pathLayer;
    CALayer *penLayer;
    
    //UIImageView *paintBgView;
    ImageMaskView *paintImageView;
    UIImageView *backgroundImageView;
    
    NSDictionary *pathDic;
    NSMutableArray *letterButtonArray;
    AppController *appDelegate;


}
@property(nonatomic, retain) IBOutlet UIButton *homeButton;
@property(nonatomic, retain) IBOutlet UIButton *uppercaseButton;
@property(nonatomic, retain) IBOutlet UIButton *lowercaseButton;

@property(nonatomic, retain) IBOutlet UIView *autoAnimateView;
@property(nonatomic, retain) IBOutlet UIView *lettersButtonBgView;

@property (nonatomic, retain) CAShapeLayer *pathLayer;
@property (nonatomic, retain) CALayer *penLayer;

@property (nonatomic, retain) ImageMaskView *paintImageView;
//@property (nonatomic, retain) IBOutlet UIImageView *paintBgView;
@property (nonatomic, retain) IBOutlet UIImageView *backgroundImageView;

@property (nonatomic, retain) NSDictionary *pathDic;
@property (nonatomic, retain) NSMutableArray *letterButtonArray;
@property (nonatomic, retain) AppController *appDelegate;


@end
