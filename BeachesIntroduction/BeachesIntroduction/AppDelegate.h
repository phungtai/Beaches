//
//  AppDelegate.h
//  BeachesIntroduction
//
//  Created by Mac on 10/23/13.
//  Copyright (c) 2013 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) UIViewController *viewController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
