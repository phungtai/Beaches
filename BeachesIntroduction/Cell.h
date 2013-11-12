//
//  Cell.h
//  BeachesIntroduction
//
//  Created by Mac on 10/23/13.
//  Copyright (c) 2013 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *star;

@end
