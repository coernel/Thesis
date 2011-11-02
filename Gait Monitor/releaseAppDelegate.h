//
//  releaseAppDelegate.h
//  GaitMonitor for iOS
//
//  Created by Sebastian Weiß on 10/25/11.
//  Copyright (c) 2011 Jade Hochschule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Record.h"

@class releaseMainViewController;

@interface releaseAppDelegate : UIResponder <UIApplicationDelegate> {

@private
//NSManagedObjectContext *managedObjectContext_;
//NSManagedObjectModel *managedObjectModel_;
//NSPersistentStoreCoordinator *persistentStoreCoordinator_;
    
    Record *record;

}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) releaseMainViewController *mainViewController;

/*
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
*/

@property (nonatomic, retain) Record *record;

@end
