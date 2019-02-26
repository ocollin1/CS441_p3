//
//  Jet.h
//  TankMeLater
//
//  Created by Owen Collins on 2/25/19.
//  Copyright © 2019 Owen Collins. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Jet : UIImageView

@property (nonatomic) float x, y;
@property (nonatomic) float dx, dy;
@property (nonatomic) int dropTime;
@end

NS_ASSUME_NONNULL_END
