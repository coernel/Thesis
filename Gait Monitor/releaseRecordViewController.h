//
//  releaseRecordViewController.h
//  GaitMonitor for iOS
//
//  Created by Sebastian Weiß on 10/25/11.
//  Copyright (c) 2011 Jade Hochschule. All rights reserved.
//



@interface releaseRecordViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSFileManager *manager;
    
}

@property (nonatomic, retain) NSFileManager *manager;

@end
