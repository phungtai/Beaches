//
//  DetailViewController.h
//  BeachesIntroduction
//
//  Created by Mac on 10/24/13.
//  Copyright (c) 2013 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController,Beaches;
#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )
#define IS_IPOD   ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )
#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_5 ( IS_IPHONE && IS_WIDESCREEN )
@interface DetailViewController : UIViewController<UITabBarDelegate>
@property (nonatomic, retain) IBOutlet UILabel * name;
@property (nonatomic, retain) IBOutlet UILabel * des;
@property (nonatomic, retain) IBOutlet UILabel * region;
@property (nonatomic, retain) IBOutlet UILabel * waveQuality;
@property (nonatomic, retain) IBOutlet UILabel * experience;
@property (nonatomic, retain) IBOutlet UILabel * suftSpotType;
@property (nonatomic, retain) IBOutlet UILabel * touristDensity;
@property (nonatomic, retain) IBOutlet UILabel * accommodations;
@property (nonatomic, retain) IBOutlet UILabel * surfTide;
@property (nonatomic, retain) IBOutlet UIImageView *imageDetailView;
@property (nonatomic, retain) IBOutletCollection (UIButton) NSArray *star;
@property (nonatomic, retain) NSArray *data;
@property (nonatomic) int index;
@property (nonatomic, strong) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIView *subView;
@property (nonatomic, strong) ViewController *parent;
@end
