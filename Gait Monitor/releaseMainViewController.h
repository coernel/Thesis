//
//  releaseMainViewController.h
//  GaitMonitor for iOS
//
//  Created by Sebastian Weiß on 10/25/11.
//  Copyright (c) 2011 Jade Hochschule. All rights reserved.
//

#import "releaseFlipsideViewController.h"
#import "releaseRecordViewController.h"
#import "Record.h"

#define kFilename	 @"data.plist"
 
@interface releaseMainViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate> {
    
    UISegmentedControl *followUpField; //UIPicker
    UISegmentedControl *jointField; //left / right choose
    UISegmentedControl *sexField; //  m / f choose
    UITextField *ageField; //UIPicker     
    UITextField *weightField; //UIPicker    
    UITextField *heightField; //UIPicker
    UITextField *studyIDField; 
    
    UIButton *viewRecordsButton;
    UIButton *clearAllButton;
    
    
}

@property (nonatomic, retain) IBOutlet UISegmentedControl *followUpField;
@property (nonatomic, retain) IBOutlet UISegmentedControl *jointField;
@property (nonatomic, retain) IBOutlet UITextField *ageField;
@property (nonatomic, retain) IBOutlet UISegmentedControl *sexField;
@property (nonatomic, retain) IBOutlet UITextField *weightField;
@property (nonatomic, retain) IBOutlet UITextField *heightField;
@property (nonatomic, retain) IBOutlet UITextField *studyIDField;


@property (nonatomic, retain) IBOutlet UIButton *viewRecordsButton;
@property (nonatomic, retain) IBOutlet UIButton *clearAllButton;

@property (retain) Record *record;


-(NSString *)dataFilePath;
- (void)applicationWillTerminate:(NSNotification *)notification;
- (IBAction)clearAll:(id)sender;
- (IBAction)backgroundTouch:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)showTable:(id)sender;


@end
