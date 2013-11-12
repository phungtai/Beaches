//
//  ViewController.h
//  BeachesIntroduction
//
//  Created by Mac on 10/23/13.
//  Copyright (c) 2013 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITabBarDelegate, UIActionSheetDelegate, UIAlertViewDelegate>
{
    IBOutlet UISearchBar *searchBar;
    NSArray *allData;
    NSMutableArray *arrName;
    IBOutlet UITabBar *tabbar;
    BOOL _filter;
    int _flag; // check sort descending or ascending
}
//@property (nonatomic, strong) NSArray *allData;
//@property (nonatomic, weak) NSMutableArray *arrName;
@property (weak, nonatomic) IBOutlet UITableView *tbView;
-(void)home;
-(void)sort;
-(void)filter;
-(void)search;
@end
