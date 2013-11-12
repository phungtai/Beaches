//
//  DetailViewController.m
//  BeachesIntroduction
//
//  Created by Mac on 10/24/13.
//  Copyright (c) 2013 MAC. All rights reserved.
//

#import "DetailViewController.h"
#import "Beaches.h"
#import "ViewController.h"
@interface DetailViewController (){
    int indexCount;
    ViewController *viewController;
}
@property (nonatomic, retain) Beaches *beach;
@end

@implementation DetailViewController
@synthesize data, index, imageDetailView, name, suftSpotType,surfTide,star,waveQuality,accommodations,touristDensity,experience,beach, myScrollView, subView,parent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    NSLog(@"%@", data);
    indexCount = index;
    [self displayData:index];
    [self addButtonNavigation];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//set data display
-(void) displayData: (int) number {
    CGRect frame = self.des.frame;
    frame.size.width = 310;
    self.des.frame = frame;
    beach = [data objectAtIndex:indexCount];
    NSString *imgName;
    if ([beach.name length]>1)
        imgName = [NSString stringWithFormat:@"%@.jpg",[beach.name stringByReplacingOccurrencesOfString:[beach.name substringToIndex:1] withString:@""]];
    else
        imgName = [NSString stringWithFormat:@"%@.jpg",[beach.name stringByReplacingOccurrencesOfString:[beach.name substringToIndex:0] withString:@""]];
    self.imageDetailView.image = [UIImage imageNamed:imgName];
    [self.name setText:beach.name];
    [self.des setText:beach.des];
    [self.des sizeToFit];
  //  NSLog(@"%f, %f", self.des.frame.size.height, self.des.frame.size.width);
    [self.region setText:beach.region];
    [self.waveQuality setText:[beach.waveQuality stringValue]];
    [self.experience setText:beach.experience];
    [self.suftSpotType setText:beach.suftSpotType];
    [self.touristDensity setText:beach.touristDensity];
    [self.accommodations setText:beach.accommodations];
    [self.surfTide setText:beach.surfTide];
    
    UIButton *bt = [[UIButton alloc]init];
    for (int j = 0 ; j < 5 ; j++) {
        bt = [self.star objectAtIndex:j];
        if (bt.selected == YES) {
            bt.selected = NO;
        }
    }
    for (int i = 0; i < [beach.waveQuality intValue]; i++) {
        bt = [self.star objectAtIndex:i];
        bt.selected = YES;
        
       // [self.view addSubview: self.myScrollView];
        //self.myScrollView.scrollEnabled = YES;
        self.subView.center = CGPointMake(160, self.des.frame.size.height+self.des.frame.origin.y+100);
        
        self.myScrollView.scrollEnabled = YES;
        [myScrollView setContentSize:CGSizeMake(300, 600)];
     //   NSLog(@"%f", self.subView.frame.size.height+self.des.frame.origin.y+self.des.frame.size.height);
  /*      if (IS_IPHONE_5) {
            self.myScrollView.contentSize = CGSizeMake(320, self.subView.frame.size.height+self.des.frame.origin.y+self.des.frame.size.height+44);
        }
        else{
            self.myScrollView.contentSize = CGSizeMake(320, self.subView.frame.size.height+self.des.frame.origin.y+self.des.frame.size.height+132);
        }*/

    }
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidUnload {
    [self setSubView:nil];
    [super viewDidUnload];
}
-(void) addButtonNavigation {
    UIBarButtonItem *btPre =[[UIBarButtonItem alloc] initWithTitle:@"Preview" style:UIBarButtonItemStylePlain target:self action:@selector(back)] ;
    UIBarButtonItem *btNext = [[UIBarButtonItem alloc]initWithTitle:@" Next " style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    self.navigationItem.rightBarButtonItems = @[btNext, btPre];
    self.navigationController.toolbar.tintColor = [UIColor blackColor];
}
-(void) back{
    if (indexCount > 0) {
    indexCount -=1;
    [self displayData:indexCount];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"This is first record" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}
-(void) next{
    if (indexCount < [data count]-1) {
        indexCount +=1;
     [self displayData:indexCount];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"This is last record" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
}
-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    switch (item.tag) {
        case 1:
            [parent home];
            break;
        case 2:
            [parent filter];
            break;
        case 3:
            [parent sort];
            break;
        case 4:
            [self search];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) search{
    
}

@end
