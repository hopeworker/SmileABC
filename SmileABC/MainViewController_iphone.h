//
//  MainViewController_iphone.h
//  SmileABC
//
//  Created by xiongwei on 13-1-28.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "RootViewController_iphone.h"
#import "FlashCardViewController_iphone.h"
#import "AnimatePathViewController_iphone.h"
@interface MainViewController_iphone : UIViewController<MFMailComposeViewControllerDelegate>
{
    //CCDirectorIOS	*director_;
    UIButton *startGame;
    UIButton *flashCard;
    UIButton *animatePathCard;
    UIButton *mail;
    RootViewController_iphone *rootViewController_iphone;
    //UILabel *animateLabel;
    UITapGestureRecognizer *tapGesture;
    //bool animationReverse;
    //bool animationReverse2;
    UIImageView *bgImageView;

    UIImageView *animateCharacter1ImageView;
    UIImageView *animateCharacter2ImageView;
    UIImageView *animateCharacter3ImageView;

}
//@property (nonatomic, retain) CCDirectorIOS	*director_;
@property (nonatomic, retain) IBOutlet UIButton *startGame;
@property (nonatomic, retain) IBOutlet UIButton *flashCard;
@property (nonatomic, retain) IBOutlet UIButton *animatePathCard;
@property (nonatomic, retain) IBOutlet UIButton *mail;
@property (nonatomic, retain) RootViewController_iphone *rootViewController_iphone;

//@property (nonatomic, retain) UILabel *animateLabel;
@property (nonatomic, retain) UITapGestureRecognizer *tapGesture;
//@property (nonatomic, assign) bool animationReverse;
@property (nonatomic, retain) IBOutlet UIImageView* bgImageView;

@property (nonatomic, retain) IBOutlet UIImageView* animateCharacter1ImageView;
@property (nonatomic, retain) IBOutlet UIImageView* animateCharacter2ImageView;
@property (nonatomic, retain) IBOutlet UIImageView* animateCharacter3ImageView;

@end
