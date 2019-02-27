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
#import <UIKit/UIGestureRecognizerSubclass.h>
//#import "Boulder.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActivityMain : UIView
@property (nonatomic, strong) UIImageView *tank;
@property float x,y,dx, dy, reloadT, newJ;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *shots, *jets;
@property (nonatomic) BOOL is_destroyed;
//@property BOOL rotating_l, rotating_r;

//@property (nonatomic, strong) NSMutableArray *boulders;
- (IBAction)right:(UIButton *)sender;



@end

NS_ASSUME_NONNULL_END
