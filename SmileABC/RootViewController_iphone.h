//
//  RootViewController_iphone.h
//  SmileABC
//
//  Created by xiongwei on 13-1-29.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "IntroLayer.h"
//#import "HelloWorldLayer.h"

@interface RootViewController_iphone : UIViewController<CCDirectorDelegate,UIGestureRecognizerDelegate>
{
    CCDirectorIOS	*director_;
    UIButton *homeButton;
    UIImageView *introduceImageView;
    UITapGestureRecognizer *tapGesture;
    UILabel *introduceLabel;
}
@property (nonatomic, retain) CCDirectorIOS	*director_;
@property (nonatomic, retain) IBOutlet UIButton	*homeButton;
@property (nonatomic, retain) IBOutlet UIImageView *introduceImageView;
@property (nonatomic, retain) UITapGestureRecognizer *tapGesture;
@property (nonatomic, retain) IBOutlet UILabel *introduceLabel;

@end
