//
//  ActivityMain.m
//  TankMeLater
//
//  Created by Owen Collins on 2/16/19.
//  Copyright © 2019 Owen Collins. All rights reserved.
//

#import "ActivityMain.h"
#import "Shot.h"
#define RELOAD ((float) 5)

@implementation ActivityMain:UIView
@synthesize tank;
@synthesize shots;


/*
@interface activityMain ()

@end

@implementation activityMain

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}*/

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        tank = [[UIImageView alloc] initWithFrame:CGRectMake(50, 225, 100, 100)];
        [tank setImage:[UIImage imageNamed:@"tank.png"]];
        [self addSubview:tank];
        self.reloadT = RELOAD;
        
        UITapGestureRecognizer *tapTargeter = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(targeter:)];
        [tapTargeter setNumberOfTapsRequired:1];
        [tapTargeter setNumberOfTouchesRequired:1];
        [self addGestureRecognizer:tapTargeter];
        
        shots = [[NSMutableArray alloc] init];
        
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self performSelectorOnMainThread:@selector(tick:) withObject:self.timer waitUntilDone:NO];
        }];
    }
    
    return self;
}

#pragma mark
-(IBAction)right:(id)sender
{
    if (self.dx < 5){
        self.dx += 5;
    }
    
    //self.dy += 5 * sin(self.angle);
    // NSLog(@"Thrust %f %f", self.dx, self.dy);
}

-(IBAction)left:(id)sender
{
    if (self.dx > -5){
        self.dx -= 5;
    }
    //self.dy += 5 * sin(self.angle);
    // NSLog(@"Thrust %f %f", self.dx, self.dy);
}

- (void) targeter: (UITapGestureRecognizer *)recognizer
{
    //check if enough time has passed to reload
    if(self.reloadT == 0){
        //Code to handle the gesture
        CGPoint target = [recognizer locationInView:[recognizer.view superview]];
        CGPoint tankPos = [tank center];
        //printf("%f, %f\n", tankPos.x, tankPos.y);
    
        Shot *s = [[Shot alloc] initWithFrame:CGRectMake(tankPos.x+10, tankPos.y-50, 60, 60)];

        //find angle
        float difTandTankX = target.x - tankPos.x;
        float difTandTankY = tankPos.y - target.y;
        s.angle = atan2f(difTandTankY,difTandTankX);
        
        
        if(s.angle<0){
            s.angle += 2*M_PI;
        }
        CGAffineTransform t = CGAffineTransformRotate(CGAffineTransformIdentity, (-1*s.angle));
        [s setTransform:t];
            
        //printf("%f, %f : %f\n", difTandTankX, difTandTankY, s.angle);
       
    
        //set speeds
        float tempCos = cosf(s.angle);
        float tempSin = sinf(s.angle);
        s.dx = 20 * tempCos;
        s.dy = -20 * tempSin;
        //printf("%f, %f\n", s.dx, s.dy);
    
        [self addSubview:s];
        [shots addObject:s];
        self.reloadT = RELOAD;
    }
        
}


-(void)tick:(id)sender
{
    
    
    CGPoint p = [tank center];
    p.x += self.dx;
    if(self.reloadT > 0){
        self.reloadT--;
    }
    //p.y += self.dy;
    
    /*
    CGRect r = [self frame];
    if (p.x < 0) p.x += r.size.width;
    if (p.x > r.size.width) p.x -= r.size.width;
    if (p.y < 0) p.y += r.size.height;
    if (p.y > r.size.height) p.y -= r.size.height;
    
    */
    [tank setCenter:p];
    
    //check shots
    CGRect r = [self frame];
    for (Shot *s in shots)
    {
        CGPoint p = [s center];
        p.x += [s dx];
        p.y += [s dy];
        [s setCenter:p];
        if (((p.x < 0) || (p.x > r.size.width)) || ((p.y < 0)||(p.y > r.size.height))){ [s removeFromSuperview]; }
        
        
    }
    
}

/*
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 */
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
