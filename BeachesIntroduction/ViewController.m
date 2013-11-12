//
//  ViewController.m
//  BeachesIntroduction
//
//  Created by Mac on 10/23/13.
//  Copyright (c) 2013 MAC. All rights reserved.
//

#import "ViewController.h"
#import "Beaches.h"
#import "AppDelegate.h"
#import "Cell.h"
#import "DetailViewController.h"
#import "AboutViewController.h"
@interface ViewController ()
{
    NSManagedObjectContext *context;
    

}

@end
@implementation ViewController
//@synthesize allData;
//@synthesize arrName;
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
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    context = [appDelegate managedObjectContext ];
    [tabbar setSelectedItem:[tabbar.items objectAtIndex:0] ];
    
    [self checkFirstLaunch];  // Check user first launch app
  //  [self addData];
    [self readData];
   // [self deleteAllData];
}
-(void)checkFirstLaunch{
    static NSString* const hasFirstRun = @"hasFirstRun";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:hasFirstRun] == NO) {
        [self addData];
        [defaults setBool:YES forKey:hasFirstRun];
    }
}
-(void)searchBar:(UISearchBar *) searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        [arrName removeAllObjects];
        [arrName addObjectsFromArray:allData];

    }
    else{
        [arrName removeAllObjects];
        NSMutableArray *getName = [[NSMutableArray alloc]init];
        Beaches *getData;
        for (int i = 0; i < [allData count]; i++) {
            getData = [allData objectAtIndex:i];
            [getName addObject:getData.name];
        }
        for (NSString *string in getName) {
            int index = [getName indexOfObject:string];
            NSRange range = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location !=NSNotFound) {
                [arrName addObject:[allData objectAtIndex:index]];
            }

        }

    }
    [self.tbView reloadData];
}
-(void) searchBarSearchButtonClicked:(UISearchBar *)aSearchBar{
    
    [searchBar resignFirstResponder];
}
-(void) searchBarCancelButtonClicked:(UISearchBar *)aSearchBar{
    [searchBar setText:nil];
    arrName = [[NSMutableArray alloc]initWithArray:allData];
    [self.tbView reloadData];
    [searchBar resignFirstResponder];
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) addData{
    Beaches *beaches = [[Beaches alloc] init];
    NSError *err;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Surf_Beaches_Database" ofType:@"csv"];
    NSString *dataFile = [[NSString alloc] initWithContentsOfFile:path encoding:NSASCIIStringEncoding error:&err];
    NSLog(@"%@",err);
    NSArray *dataRow = [dataFile componentsSeparatedByString:@",,,,,,,,"];
    NSLog(@"%d", [dataRow count]);
    for (int i = 1; i < [dataRow count]; i++) {
        NSArray *dataElement = [[dataRow objectAtIndex:i] componentsSeparatedByString:@","];
        if ([dataElement count] == 9) {
        
                beaches =(Beaches*)[NSEntityDescription insertNewObjectForEntityForName:@"Beaches" inManagedObjectContext:context];
                beaches.name = [[dataElement objectAtIndex:0]stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
                beaches.des = [dataElement objectAtIndex:1];
                beaches.region = [dataElement objectAtIndex:2];
                beaches.waveQuality = [NSNumber numberWithInt:[[dataElement objectAtIndex:3] intValue]];
                beaches.experience = [dataElement objectAtIndex:4];
                beaches.suftSpotType = [dataElement objectAtIndex:5];
                beaches.touristDensity = [dataElement objectAtIndex:6];
                beaches.accommodations = [dataElement objectAtIndex:7];
                beaches.surfTide = [dataElement objectAtIndex:8];
                
                NSError *error;
                [context save:&error];
                NSLog(@"%@",error);
            
        }
    }
}
-(void) readData{
    NSEntityDescription *entityDes = [NSEntityDescription entityForName:@"Beaches" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDes];
    NSError *err;
    allData = [context executeFetchRequest:request error:&err];
    arrName = [NSMutableArray arrayWithArray:allData];
    NSLog(@"%d", [allData count]);
  //  NSString *myIdentifier = @"itemCellIdentifier";
  //  [self.tbView registerNib:[UINib nibWithNibName:@"Cell" bundle:nil] forCellReuseIdentifier:myIdentifier];
}
-(void) deleteAllData{
    NSEntityDescription *entityDes = [NSEntityDescription entityForName:@"Beaches" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDes];
    NSError *err;
    //  allData = [context executeFetchRequest:request error:&err];
    if(allData.count ==0){
        NSLog(@"Khong có dữ liệu");
    }
    else{
        for (NSManagedObject *obj in allData) {
            [context deleteObject:obj];
        }
        NSLog(@"%@",err);
        NSLog(@"da xoa xong du lieu");
        [context save:&err];
    }
    
}
// Custom Table cell
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma UITableView
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%d", [arrName count]);
    return [arrName count];
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString static *myIdentifier = @"Cell";
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];

if(cell == nil){
    NSArray *allNibObject = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:nil options:nil];
    for (id currentObject in allNibObject) {
        if ([currentObject isKindOfClass:[Cell class]]) {
            cell =(Cell *) currentObject;
        }
    }
    
}   Beaches *beaches = [Beaches new];
    beaches = [arrName objectAtIndex:indexPath.row];
    for(int i = 0; i< [beaches.waveQuality intValue] ; i++){
        UIButton *bt = [[UIButton alloc] init];
        bt = [cell.star objectAtIndex:i];
        bt.selected = YES;
    }
    NSString *imgName = nil;
    if ([beaches.name length]>1)
        imgName = [NSString stringWithFormat:@"%@.jpg",[beaches.name stringByReplacingOccurrencesOfString:[beaches.name substringToIndex:1] withString:@""]];
    else
        imgName = [NSString stringWithFormat:@"%@.jpg",[beaches.name stringByReplacingOccurrencesOfString:[beaches.name substringToIndex:0] withString:@""]];
    if (![imgName isEqualToString:@""])
        cell.imageView.image = [UIImage imageNamed:imgName];
    [cell.description setText:beaches.des];
    [cell.name setText:beaches.name];
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *secondView = [[DetailViewController alloc] init];
    [self.tbView deselectRowAtIndexPath:indexPath animated:YES];
    //secondView.data = [allData objectAtIndex:indexPath.row];
    secondView.data = arrName;
    secondView.index = indexPath.row;
    secondView.parent = self;
    [self.navigationController pushViewController:secondView animated:YES];
    
}
-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    switch (item.tag) {
        case 1:
            [self home];
            break;
        case 2:
            [self filter];
            break;
        case 3:
            [self sort];
            break;
        case 4:
            [self about];
            break;
    }
}
-(void) home{
    arrName = [[NSMutableArray alloc] initWithArray:allData];
    [self.tbView reloadData];
}
-(void) filter{
    _filter = YES;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"List" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Wave Quality", @"Experience", @"Tourist Density",@"Accomodations", @"Region", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}
-(void) sort{
    _filter = NO;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"List" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Wave Quality", @"Experience",@"Tourist Density",@"Accomodations", @"Region", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}
-(void) search{
    
}
-(void) about{
    AboutViewController *aboutView = [[AboutViewController alloc] init];
    [self.navigationController pushViewController:aboutView animated:YES];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (_filter == YES) {
        switch (buttonIndex) {
            case 0:
                [self filterWaveQuality];
                break;
            case 1:
                [self filterExperience];
                break;
            case 2:
                [self filterTouristDensity];
                break;
            case 3:
                [self filterAccommodations];
                break;
            case 4:
                [self filterRegion];
                break;
        }
    }
    else{
        switch (buttonIndex) {
            case 0:

                [self sortWaveQuality];
                break;
            case 1:
                [self sortExperience];
                break;
            case 2:
                [self sortTouristDensity];
                break;
            case 3:
                [self sortAccommodations];
                break;
            case 4:
                [self sortRegion];
                break;
                
        }
        
    }
}
-(void) filterWaveQuality{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wave Quality" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [[alert textFieldAtIndex:0] setPlaceholder:@"Range integer 1 ~ 5"];
    [alert setTag:0];
    [alert show];
    
}
-(void) filterExperience{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Experience" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"All",@"Experience",@"Pros",nil];
    [alert setTag:1];
   // [alert setCancelButtonIndex:3];
    [alert show];
}

-(void) filterTouristDensity{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"TouristDensity" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Low",@"Medium",@"Crowded",nil];
    [alert setTag:2];
    [alert show];
}
-(void) filterAccommodations{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Accommodations" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"None",@"Limited",@"Good",nil];
    [alert setTag:3];
    [alert show];
}
-(void) filterRegion{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Region" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Puntarenas",@"Guanacaste",@"Limon",nil];
    [alert setTag:4];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
 //Case filter
        case 0:
            if (buttonIndex == 1) {
            int wave = [[[alertView textFieldAtIndex:0] text] intValue];
                if (wave >=1 && wave <= 5) {
                    [arrName removeAllObjects];
                    NSPredicate *filter = [NSPredicate predicateWithFormat:@"waveQuality = %@", [NSNumber numberWithInt:wave]];
                    //[self resetSearch];
                    NSMutableArray *temp = [NSMutableArray arrayWithArray:[allData filteredArrayUsingPredicate:filter]];
                    arrName = temp;
                    [self.tbView reloadData];
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Input value  range is not integer 1 ~ 5 " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            }
            break;
            
        case 1:
            if (buttonIndex == 1) {
                [arrName removeAllObjects];
                NSPredicate *filter = [NSPredicate predicateWithFormat:@"experience = %@", @"All"];
                NSMutableArray *temp = [NSMutableArray arrayWithArray:[allData filteredArrayUsingPredicate:filter]];
                NSLog(@"%d", [temp count]);
                arrName = temp;
                [self.tbView reloadData];
            }
            else if(buttonIndex == 2) {
                [arrName removeAllObjects];
                NSPredicate *filter = [NSPredicate predicateWithFormat:@"experience = %@", @"Experienced"];
                NSMutableArray *temp = [NSMutableArray arrayWithArray:[allData filteredArrayUsingPredicate:filter]];
                NSLog(@"%d", [temp count]);
                arrName = temp;
                [self.tbView reloadData];
            }
            else if (buttonIndex == 3){
                [arrName removeAllObjects];
                NSPredicate *filter = [NSPredicate predicateWithFormat:@"experience = %@", @"Pros"];
                NSMutableArray *temp = [NSMutableArray arrayWithArray:[allData filteredArrayUsingPredicate:filter]];
                arrName = temp;
                [self.tbView reloadData];
            }
            break;
        case 2:
            if (buttonIndex == 1) {
                [arrName removeAllObjects];
                NSPredicate *filter = [NSPredicate predicateWithFormat:@"touristDensity = %@", @"Low"];
                NSMutableArray *temp = [NSMutableArray arrayWithArray:[allData filteredArrayUsingPredicate:filter]];
                arrName = temp;
                [self.tbView reloadData];
            }
            if (buttonIndex == 2) {
                [arrName removeAllObjects];
                NSPredicate *filter = [NSPredicate predicateWithFormat:@"touristDensity = %@", @"Medium"];
                NSMutableArray *temp = [NSMutableArray arrayWithArray:[allData filteredArrayUsingPredicate:filter]];
                arrName = temp;
                [self.tbView reloadData];
            }
            if (buttonIndex == 3) {
                [arrName removeAllObjects];
                NSPredicate *filter = [NSPredicate predicateWithFormat:@"touristDensity = %@", @"Crowded"];
                NSMutableArray *temp = [NSMutableArray arrayWithArray:[allData filteredArrayUsingPredicate:filter]];
                arrName = temp;
                [self.tbView reloadData];
            }
            break;
        case 3:
            if (buttonIndex == 1) {
                [arrName removeAllObjects];
                NSPredicate *filter = [NSPredicate predicateWithFormat:@"accommodations = %@", @"None"];
                NSMutableArray *temp = [NSMutableArray arrayWithArray:[allData filteredArrayUsingPredicate:filter]];
                arrName = temp;
                [self.tbView reloadData];
            }
            if (buttonIndex == 2 ) {
                [arrName removeAllObjects];
                NSPredicate *filter = [NSPredicate predicateWithFormat:@"accommodations = %@", @"Limited"];
                NSMutableArray *temp = [NSMutableArray arrayWithArray:[allData filteredArrayUsingPredicate:filter]];
                arrName = temp;
                [self.tbView reloadData];
            }
            if (buttonIndex == 3) {
                [arrName removeAllObjects];
                NSPredicate *filter = [NSPredicate predicateWithFormat:@"accommodations = %@", @"Good"];
                NSMutableArray *temp = [NSMutableArray arrayWithArray:[allData filteredArrayUsingPredicate:filter]];
                arrName = temp;
                [self.tbView reloadData];
            }
            break;
        case 4:
            if (buttonIndex == 1) {
                [arrName removeAllObjects];
                NSPredicate *filter = [NSPredicate predicateWithFormat:@"region = %@", @"Puntarenas"];
                NSMutableArray *temp = [NSMutableArray arrayWithArray:[allData filteredArrayUsingPredicate:filter]];
                arrName = temp;
                [self.tbView reloadData];
            }
            if (buttonIndex == 2 ) {
                [arrName removeAllObjects];
                NSPredicate *filter = [NSPredicate predicateWithFormat:@"region = %@", @"Guanacaste"];
                NSMutableArray *temp = [NSMutableArray arrayWithArray:[allData filteredArrayUsingPredicate:filter]];
                arrName = temp;
                [self.tbView reloadData];
            }
            if (buttonIndex == 3) {
                [arrName removeAllObjects];
                NSPredicate *filter = [NSPredicate predicateWithFormat:@"region = %@", @"Limon"];
                NSMutableArray *temp = [NSMutableArray arrayWithArray:[allData filteredArrayUsingPredicate:filter]];
                arrName = temp;
                [self.tbView reloadData];
            }

            break;
 //case Sort
         case 5:
            if (buttonIndex == 1) {
                [self sort:@"waveQuality" ascending:NO];
                [self.tbView reloadData];
                
            }
            else if (buttonIndex == 2){
                [self sort:@"waveQuality" ascending:YES];
                [self.tbView reloadData];
            }
            break;
        case 6:
            if (buttonIndex == 1) {
                [self sort:@"experience" ascending:NO];
                [self.tbView reloadData];
                
            }
            else if (buttonIndex == 2){
                [self sort:@"experience" ascending:YES];
                [self.tbView reloadData];
            }
            break;
        case 7:
            if (buttonIndex == 1) {
                [self sort:@"touristDensity" ascending:NO];
                [self.tbView reloadData];
                
            }
            else if (buttonIndex == 2){
                [self sort:@"touristDensity" ascending:YES];
                [self.tbView reloadData];
            }
            break;
        case 8:
            if (buttonIndex == 1) {
                [self sort:@"accommodations" ascending:NO];
                [self.tbView reloadData];
                
            }
            else if (buttonIndex == 2){
                [self sort:@"accommodations" ascending:YES];
                [self.tbView reloadData];
            }
            break;
        case 9:
            if (buttonIndex == 1) {
                [self sort:@"region" ascending:NO];
                [self.tbView reloadData];
                
            }
            else if (buttonIndex == 2){
                [self sort:@"region" ascending:YES];
                [self.tbView reloadData];
            }
            break;

    }
    
}
-(void)sort: (NSString *) keyName ascending:(BOOL)bol{
    NSSortDescriptor * sortByScore = [NSSortDescriptor sortDescriptorWithKey:keyName ascending:bol];
    [arrName sortUsingDescriptors:[NSArray arrayWithObject:sortByScore]];

}

-(void) sortWaveQuality{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sort" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Descending",@"Ascending", nil];
    [alert setTag:5];
    [alert show];
    
}
-(void) sortExperience{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sort" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Descending",@"Ascending", nil];
    [alert setTag:6];
    [alert show];
}
-(void) sortTouristDensity{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sort" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Descending",@"Ascending", nil];
    [alert setTag:7];
    [alert show];
}
-(void) sortAccommodations{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sort" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Descending",@"Ascending", nil];
    [alert setTag:8];
    [alert show];
}
-(void) sortRegion{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sort" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Descending",@"Ascending", nil];
    [alert setTag:9];
    [alert show];
}
@end
