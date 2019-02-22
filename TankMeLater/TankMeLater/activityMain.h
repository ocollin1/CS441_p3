//
//  activityMain.h
//  TankMeLater
//
//  Created by Owen Collins on 2/16/19.
//  Copyright © 2019 Owen Collins. All rights reserved.
//
/*
#import "ViewController.h"

@interface activityMain : ViewController{
    
    IBOutlet UIImageView *tank;
    IBOutlet UIButton *LeftArrow;
    IBOutlet UIButton *RightArrow;
    IBOutlet UIImageView *ImageView;
    
    
}

@end
*/

#import <UIKit/UIKit.h>
//#import "Boulder.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameView : UIView
@property (nonatomic, strong) UIImageView *tank;
@property float dx, dy;
@property (nonatomic, strong) NSTimer *timer;
//@property BOOL rotating_l, rotating_r;

//@property (nonatomic, strong) NSMutableArray *boulders;
@end

NS_ASSUME_NONNULL_END
