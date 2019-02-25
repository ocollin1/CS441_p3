//
//  Jet.m
//  TankMeLater
//
//  Created by Owen Collins on 2/25/19.
//  Copyright © 2019 Owen Collins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jet.h"
@implementation Jet

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.dx = 0;
        self.dy = 0;
    }
    
    return self;
}

@end
