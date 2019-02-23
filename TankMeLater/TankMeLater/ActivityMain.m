//
//  ActivityMain.m
//  TankMeLater
//
//  Created by Owen Collins on 2/16/19.
//  Copyright © 2019 Owen Collins. All rights reserved.
//

#import "ActivityMain.h"

@implementation ActivityMain:UIView
@synthesize tank;


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
        /*
        UITapGestureRecognizer *tapTargeter = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(targeter:)];
        [tapTargeter setNumberOfTapsRequired:1];
        [tapTargeter setNumberOfTouchesRequired:1];
        [self addGestureRecognizer:tapTargeter];
        */
        
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
/*
- (void) targeter: (UITapGestureRecognizer *)recognizer
{
    //Code to handle the gesture
    
    
}
*/

-(void)tick:(id)sender
{
    
    
    CGPoint p = [tank center];
    p.x += self.dx;
    //p.y += self.dy;
    
    /*
    CGRect r = [self frame];
    if (p.x < 0) p.x += r.size.width;
    if (p.x > r.size.width) p.x -= r.size.width;
    if (p.y < 0) p.y += r.size.height;
    if (p.y > r.size.height) p.y -= r.size.height;
    
    */
    [tank setCenter:p];
    
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
