//
//  shot.m
//  TankMeLater
//
//  Created by Owen Collins on 2/24/19.
//  Copyright © 2019 Owen Collins. All rights reserved.
//

#import "Shot.h"

@implementation Shot

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setImage:[UIImage imageNamed:@"Shot.png"]];
    }
    
    return self;
}

@end
