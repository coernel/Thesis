//
//  releaseFlipsideViewController.h
//  GaitMonitor for iOS
//
//  Created by Sebastian Weiß on 10/25/11.
//  Copyright (c) 2011 Jade Hochschule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <CoreLocation/Corelocation.h>
#import <AudioToolbox/AudioToolbox.h>

#import "releaseRecordViewController.h"
#import "releaseMainViewController.h"
#import "Record.h"


#define kFilename		@"data.plist"
#define kUpdateFrequency 100 //Hz


@class releaseFlipsideViewController;

@protocol releaseFlipsideViewControllerDelegate;


@interface releaseFlipsideViewController : UIViewController <UIAlertViewDelegate, MFMailComposeViewControllerDelegate, UIAccelerometerDelegate, CLLocationManagerDelegate> {
    id <releaseFlipsideViewControllerDelegate> delegate;
    
     UIButton *startButton; 
     UIButton *mailButton;
     UIButton *patientDataButton;
     UIButton *stopButton;
    
    NSMutableArray *valueArray;
    
    CLLocationManager *locationManager;
    CLLocation *startingLocation;
    
    
    SystemSoundID startSound;
    SystemSoundID stopSound;
    SystemSoundID errorSound;
    SystemSoundID prepareSound;
    
}

- (IBAction)newPatientData:(id)sender;
- (IBAction)mailRecord;
- (void)recordStart;
- (IBAction)recordStop;
- (IBAction)startRecordAfterDelay;

-(void)useData:(Record *)aRecord;

- (NSString *)dataFilePath;
- (NSString *)fileName;
- (NSString *)setFileLocation;


@property (nonatomic, retain) IBOutlet UIButton *startButton;
@property (nonatomic, retain) IBOutlet UIButton *stopButton;
@property (nonatomic, retain) IBOutlet UIButton *mailButton;
@property (nonatomic, retain) IBOutlet UIButton *patientDataButton;

@property (nonatomic, retain) CLLocation *startingLocation;
@property (nonatomic, retain) CLLocationManager *locationManager;




@property (nonatomic, assign) id <releaseFlipsideViewControllerDelegate> delegate;
//@property (weak, nonatomic) IBOutlet id <releaseFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end

@protocol releaseFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(releaseFlipsideViewController *)controller;
@end



