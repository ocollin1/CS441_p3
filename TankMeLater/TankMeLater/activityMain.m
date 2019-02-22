//
//  activityMain.m
//  TankMeLater
//
//  Created by Owen Collins on 2/16/19.
//  Copyright © 2019 Owen Collins. All rights reserved.
//

#import "activityMain.h"

@implementation GameView
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
        tank = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 150, 100)];
        [tank setImage:[UIImage imageNamed:@"tank"]];
        [self addSubview:tank];
        
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self performSelectorOnMainThread:@selector(tick:) withObject:self.timer waitUntilDone:NO];
        }];
    }
    
    return self;
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
