//
//  FlashCardViewController_iphone.h
//  SmileABC
//
//  Created by xiongwei on 13-1-29.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface FlashCardViewController_iphone : UIViewController<UIGestureRecognizerDelegate>
{
    UIImageView *bgImageView;
    UIImageView *uppercaseLetterImageView;
    UIImageView *lowercaseLetterImageView;

    UIImageView *letterCharacterImageView;
    UIButton *voiceButton;
    UIButton *homeButton;
    
    UIButton *nextButton;
    UIButton *previousButton;

    AppController *appDelegate;
    NSInteger cur_letter_index;
        
    UITapGestureRecognizer *tapGesture;
    UILabel *letterCharacterWordLabel;


}
@property (nonatomic, retain) IBOutlet UIImageView *bgImageView;
@property (nonatomic, retain) IBOutlet UIImageView *uppercaseLetterImageView;
@property (nonatomic, retain) IBOutlet UIImageView *lowercaseLetterImageView;

@property (nonatomic, retain) IBOutlet UIImageView *letterCharacterImageView;
@property (nonatomic, retain) IBOutlet UILabel *letterCharacterWordLabel;

@property (nonatomic, retain) IBOutlet UIButton *voiceButton;
@property (nonatomic, retain) IBOutlet UIButton *homeButton;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;
@property (nonatomic, retain) IBOutlet UIButton *previousButton;

@property (nonatomic, assign) NSInteger cur_letter_index;
@property (nonatomic, retain) UITapGestureRecognizer *tapGesture;
@property (nonatomic, retain) AppController *appDelegate;
@end
