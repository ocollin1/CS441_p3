//
//  ActivityMain.m
//  TankMeLater
//
//  Created by Owen Collins on 2/16/19.
//  Copyright © 2019 Owen Collins. All rights reserved.
//

#import "ActivityMain.h"
#import "Shot.h"
#import "Jet.h"
#define RELOAD ((float) 5)
#define JET_TIME ((int) 30)
#define SHOT_SPEED ((int) 30)
#define TANK_SPEED ((int) 10)
#define MAIN_TIME ((int) 40)

@implementation ActivityMain:UIView
@synthesize tank;
@synthesize shots;
@synthesize jets;
@synthesize shotsToRemove;
@synthesize jetsToRemove;
@synthesize timeM, timeS, jetTime;
@synthesize retButton;

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
        tank = [[UIImageView alloc] initWithFrame:CGRectMake(50, 240, 70, 70)];
        [tank setImage:[UIImage imageNamed:@"tankRight.png"]];
        [self addSubview:tank];
        self.reloadT = RELOAD;
        self.newJ = JET_TIME;
        self.is_destroyed = false;
        
        UITapGestureRecognizer *tapTargeter = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(targeter:)];
        [tapTargeter setNumberOfTapsRequired:1];
        [tapTargeter setNumberOfTouchesRequired:1];
        [self addGestureRecognizer:tapTargeter];
        
        shots = [[NSMutableArray alloc] init];
        
        jets = [[NSMutableArray alloc] init];
        
        shotsToRemove = [[NSMutableArray alloc] init];
        
        jetsToRemove = [[NSMutableArray alloc] init];
        
        timeM = MAIN_TIME;
        timeS = 0;
        jetTime = JET_TIME;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self performSelectorOnMainThread:@selector(tick:) withObject:self.timer waitUntilDone:NO];
        }];
    }
    
    return self;
}

#pragma mark
-(IBAction)right:(id)sender
{
    if (self.dx < TANK_SPEED && !self.is_destroyed){
        self.dx = TANK_SPEED;
        [tank setImage:[UIImage imageNamed:@"tankRight.png"]];
    } else if(self.dx == TANK_SPEED){
        
    }
    
    //self.dy += 5 * sin(self.angle);
    // NSLog(@"Thrust %f %f", self.dx, self.dy);
}

-(IBAction)left:(id)sender
{
    
    if (self.dx > -TANK_SPEED && !self.is_destroyed){
        self.dx = -1*TANK_SPEED;
        [tank setImage:[UIImage imageNamed:@"tankLeft.png"]];
    }else if(self.dx == -TANK_SPEED){
        
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
    
        Shot *s = [[Shot alloc] initWithFrame:CGRectMake(tankPos.x+10, tankPos.y-50, 50, 50)];

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
        s.dx = SHOT_SPEED* tempCos;
        s.dy = -SHOT_SPEED * tempSin;
        //printf("%f, %f\n", s.dx, s.dy);
        
        s.is_bomb = false;
    
        [self addSubview:s];
        [shots addObject:s];
        self.reloadT = RELOAD;
    }
        
}

-(void)toFront:(id)sender{
    
    [self bringSubviewToFront:sender];
    
}


-(void)tick:(id)sender
{
    
    if(self.is_destroyed){
        
        //end
        
        
        if(tank.alpha == 1.0){
            
           
            CGPoint tankPos = [tank center];
            CGRect r = CGRectMake(tankPos.x, tankPos.y-160, 200, 200);
            [tank setFrame:r];
            [tank setImage:[UIImage imageNamed:@"endEx"]];
            for (Shot *s in shots){
                
                CGPoint p = [s center];
                p.x = 0;
                p.y = 0;
                [s setCenter:p];
                //[shotsToRemove addObject:s];
                [s removeFromSuperview];
                
            }
            
            for (Jet *j in jets){
                
                CGPoint p = [j center];
                p.x = 0;
                p.y = 0;
                [j setCenter:p];
                //[shotsToRemove addObject:s];
                [j removeFromSuperview];
                
                
            }
            
            tank.alpha -= 0.05;
            
        } else if ( tank.alpha == 0){
            
            
        } else {
            tank.alpha -= 0.05;
            
        }
        
        //figure out segue
        
    } else {
    
    CGRect r = [self frame];
    CGPoint p = [tank center];
    if( p.x >= r.size.width || p.x < 0 ){
        self.dx *= -1;
        
    }
    p.x += self.dx;
    
    if(self.reloadT > 0){
        self.reloadT--;
    }
        
    [tank setCenter:p];
    
    //check shots
    
    for (Shot *s in shots)
    {
        
        CGPoint p = [s center];
        p.x += [s dx];
        p.y += [s dy];
        [s setCenter:p];
        if (((p.x < 0) || (p.x > r.size.width)) || ((p.y < 0)||(p.y > r.size.height))){ [s removeFromSuperview]; }
        if(s.is_bomb && CGRectIntersectsRect(tank.frame, s.frame)){
            
            self.is_destroyed = true;
            
        }
        
    }
    
    //randomly build jets
    if(self.newJ > 0){
        self.newJ--;
    } else {
        
        int direction = arc4random_uniform(10); //either right or left
        int height = arc4random_uniform(175);   //y coord
        Jet *j;
        //j.notHit = true;
        if(direction < 5){
            j = [[Jet alloc] initWithFrame:CGRectMake(0, height, 60, 60)];
            [j setImage:[UIImage imageNamed:@"rightJet"]];
            [j setDx:(rand() % 14)+6];
        } else {
            j = [[Jet alloc] initWithFrame:CGRectMake(r.size.width-50, height, 60, 60)];
            [j setImage:[UIImage imageNamed:@"leftJet"]];
            [j setDx:(rand() % 14)+6];
            j.dx *= -1;
        }
        [self addSubview:j];
        [jets addObject:j];
        
        self.newJ = jetTime;
    }
    
    //move jets
    for (Jet *j in jets)
    {
        if(j.notHit){
            
            CGPoint p = [j center];
            p.x += [j dx];
            p.y += [j dy];
            //check dropped bomb
            if(j.dropTime == 0){
                //drop bomb!
            
                Shot *s = [[Shot alloc] initWithFrame:CGRectMake(p.x, p.y, 30, 30)];
                s.dx = 0;
                s.is_bomb = true;
                s.dy = SHOT_SPEED;
                s.angle = M_PI/2;
                CGAffineTransform t = CGAffineTransformRotate(CGAffineTransformIdentity, (s.angle));
                [s setTransform:t];
                [self addSubview:s];
                [shots addObject:s];
            
            
                j.dropTime--;
            }
            j.dropTime--;
            if ((p.x < 0) || (p.x > r.size.width)){ [j removeFromSuperview]; }
        
            
            //collision detection
            for (Shot *s in shots)
                {
                if( (CGRectIntersectsRect(j.frame, s.frame) && !s.is_bomb) && j.notHit){

                    j.notHit = false;
                    j.dx = 0;
                    [j setImage:[UIImage imageNamed:@"jetEx"]];
                    CGAffineTransform t = CGAffineTransformRotate(CGAffineTransformIdentity, -1*(s.angle));
                    [j setTransform:t];
                    CGPoint p = [s center];
                    p.x = -50;
                    p.y = -50;
                    [s setCenter:p];
                    //[shotsToRemove addObject:s];
                    [s removeFromSuperview];
                }
            }
            
            
            
        
            [j setCenter:p];
            
        } else {
            
            if(j.alpha > 0){
                j.alpha -= 0.05; //reduce opacity
            } else {
                //[jetsToRemove addObject:j];
                [j removeFromSuperview];
            }
            
        }
        
        //[shots removeObjectsInArray:shotsToRemove];
        //[shotsToRemove removeAllObjects];
        
        //[jets removeObjectsInArray:jetsToRemove];
        //[jetsToRemove removeAllObjects];
        
        
    }
    
    if(timeM < 1){
        
        jetTime = JET_TIME - timeS;
        timeS += 1;
        timeM = MAIN_TIME;
        
    }else{
        timeM--;
        
    }
    
    
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
