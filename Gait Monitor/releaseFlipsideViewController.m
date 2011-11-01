//
//  releaseFlipsideViewController.m
//  GaitMonitor for iOS
//
//  Created by Sebastian Weiß on 10/25/11.
//  Copyright (c) 2011 Jade Hochschule. All rights reserved.
//

#import "releaseFlipsideViewController.h"

@implementation releaseFlipsideViewController


@synthesize delegate = __delegate;

@synthesize mailButton;
@synthesize stopButton;
@synthesize startButton;
@synthesize patientDataButton;

@synthesize startingLocation;
@synthesize locationManager;


int i = 0;
BOOL permission = NO;    



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    //Register Accelerometer
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0 / kUpdateFrequency];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    
    //Register CoreLocation
    self.locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; //acquire best possible location data
    
    //get location
    [locationManager startUpdatingLocation];
    
    valueArray = [[NSMutableArray alloc] init];
    
    [stopButton setEnabled:NO];
    [stopButton setTitleColor:[UIColor colorWithRed:0.424 green:0.424 blue:0.424 alpha:1.000] forState:UIControlStateDisabled];
    self.view.backgroundColor = [UIColor colorWithRed:0.604 green:0.604 blue:0.604 alpha:1.000];
    
    //preparing sounds
    NSString *pathToStartSound = [[NSBundle mainBundle] pathForResource:@"pleaseStartWalking" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:pathToStartSound], &startSound);
    
    NSString *pathToStopSound = [[NSBundle mainBundle] pathForResource:@"recordingDone" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:pathToStopSound], &stopSound);
    
    NSString *pathToPrepareSound = [[NSBundle mainBundle] pathForResource:@"getReady" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:pathToPrepareSound], &prepareSound);
    
    NSString *pathToErrorSound = [[NSBundle mainBundle] pathForResource:@"error" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:pathToErrorSound], &errorSound);
}

- (void)viewWillAppear:(BOOL)animated {
    //reset the backgroundcolor to grey when the view reappears (e.g. after altering patient data)
    
    self.view.backgroundColor = [UIColor colorWithRed:0.604 green:0.604 blue:0.604 alpha:1.000];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return YES;
}


-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
	
    UIInterfaceOrientation toOrientation = self.interfaceOrientation;
    
	if (toOrientation == UIInterfaceOrientationPortrait || toOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		startButton.frame = CGRectMake(53, 81, 96, 100);
        stopButton.frame  = CGRectMake(159, 81, 96, 100);                             
		mailButton.frame = CGRectMake(53, 196, 200, 100);
		patientDataButton.frame = CGRectMake(53, 309, 200, 100);
	}
	else {
		startButton.frame = CGRectMake(77, 60, 160, 64);
        stopButton.frame = CGRectMake(243, 60, 160, 64);
		mailButton.frame = CGRectMake(77, 144, 326, 64);
		patientDataButton.frame = CGRectMake(77, 226, 326, 64);
	}
}

#pragma mark
#pragma mark Application Quits

-(void)applicationWillTerminate:(NSNotification *)notification {
    // handle termination application
    
}

#pragma mark
#pragma mark File locating methods

//getting the file that holds name and last name of the patient for we need it for the file name
-(NSString *)dataFilePath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    
	return [documentsDirectory stringByAppendingPathComponent:kFilename];
    
    
    
    // **** ALL FINE HERE **** // 
    
}

//defining the filename for .csv

-(NSString *)fileName {
    
    //ersetzen
	
//	return [fileName stringByAppendingString:@".csv";
    
  //  NSLog(@"%@",fileName);
    
    // **** ALL FINE HERE **** //
    
        
} // fertig

//setting file location
-(NSString *)setFileLocation { 	
    
    NSArray *sysPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory = [sysPaths objectAtIndex:0];
    NSString *fileName = [self fileName];   
	NSString *fullFilePath = [NSString stringWithFormat:@"%@/%@", docDirectory,fileName];
    NSLog(@"Filepath is : %@",fullFilePath);
	return fullFilePath;
} //fertig


- (void)startRecordAfterDelay {
    AudioServicesPlaySystemSound(prepareSound);
    [self performSelector:@selector(recordStart) withObject:nil afterDelay:5 ];
    
    //give background a yellow color, get ready to record
    self.view.backgroundColor = [UIColor colorWithRed:0.996 green:1.000 blue:0.349 alpha:1.000];
} // Starting and Stopping the record after a 5 second countdown

- (void)recordStart { //setting permission to yes
    AudioServicesPlaySystemSound(startSound);
    
    
    if (permission == NO) {
        permission = YES;
        
        //Redesign Buttons for recording state
        
        [startButton setEnabled:NO];
        [startButton setTitleColor:[UIColor colorWithRed:0.424 green:0.424 blue:0.424 alpha:1.000] forState:UIControlStateDisabled];
        [stopButton setEnabled:YES];
        [mailButton setEnabled:NO];
        [mailButton setTitleColor:[UIColor colorWithRed:0.424 green:0.424 blue:0.424 alpha:1.000] forState:UIControlStateDisabled];
        [patientDataButton setEnabled:NO];
        [patientDataButton setTitleColor:[UIColor colorWithRed:0.424 green:0.424 blue:0.424 alpha:1.000] forState:UIControlStateDisabled];
        
        
    }
    //give background a green color, recording state.
    self.view.backgroundColor = [UIColor colorWithRed:0.000 green:0.639 blue:0.059 alpha:1.000];
    
} 

- (void)recordStop { //setting permission to no
    
    if (permission == YES) {
        permission = NO;
    }    
    
    //vibrate, play stop sound
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(stopSound);
    
    //   NSLog(@"Array Count: %d", [valueArray count]);
    
    if ([valueArray count] == 0) {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"An error occured, please repeat"
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [error show];
        [error release];
        
        AudioServicesPlaySystemSound(errorSound);
        
        self.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.027 blue:0.090 alpha:1.000];
    }
    
    else {
    NSString *headString = [record getFileHeader];
    
   
    [headString  writeToFile:[self setFileLocation] atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    [[valueArray componentsJoinedByString:@",\n"] writeToFile:[self setFileLocation] atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    
    
    
    //give background a blue color, recording is finished
    
    self.view.backgroundColor = [UIColor colorWithRed:0.000 green:0.027 blue:1.090 alpha:1.000];
    
    //Redesign Buttons for normal state
    [stopButton setEnabled:NO];
    [stopButton setTitleColor:[UIColor colorWithRed:0.424 green:0.424 blue:0.424 alpha:1.000] forState:UIControlStateDisabled];
    [startButton setEnabled:YES];
    [mailButton setEnabled:YES];
    [patientDataButton setEnabled:YES];
    
    //show done message
    UIAlertView *done = [[UIAlertView alloc] initWithTitle:@"Recording finished" 
                                                   message:@"Your gait was recorded"
                                                  delegate:self cancelButtonTitle:@"OK" 
                     
                                        otherButtonTitles:nil, nil];
        [done show];
        [done release]; 
        
        return;
    }
    
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	
    if (permission == YES) {
        
        float x,y,z;
        
        x = acceleration.z*(-1);
        y = acceleration.y*(-1);
        z = acceleration.x;
        
        
        //   NSLog(@"%f"@"f"@"%f"@"%f"@"%f"@"%f"@"%f",acceleration.x,z,acceleration.y,y,acceleration.z,x);
        NSString *valueString = [NSString stringWithFormat:@"%f, %f, %f",x,y,z];
        
        [valueArray insertObject:valueString atIndex:i];
        
        NSLog(@"%i",i);
        i++;
        NSLog(@"Array Count: %d", [valueArray count]);    
    }
} //fertig


-(void)newPatientData:(id)sender {
    
    releaseMainViewController *controller = [[releaseMainViewController alloc] initWithNibName:@"releaseMainViewController" bundle:nil];
		
	controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	[self presentModalViewController:controller animated:YES];
	
}
	

#pragma mark
#pragma mark Mail


-(void)mailRecord {
    
    if([MFMailComposeViewController canSendMail]) {
        
        //Load MailComposer
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        
        //set email subject
        [picker setSubject:@"Gaitrecord"];
        
        
        //getting file name
        NSString *fileName = [self fileName]; //the filename is loaded from the filename() function,
        //which is declared and executed at the top of the file
        
        //locating .csv file
        NSArray *sysPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDirectory = [sysPaths objectAtIndex:0];
        NSString *fullFilePath = [NSString stringWithFormat:@"%@/%@", docDirectory,fileName];
        
        NSLog(@"Path is: %@",fullFilePath);
        
        //---------- FORMATTING EMAIL ----------//
        
        //setting up Timestamp
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        
        NSDate *date = [[NSDate alloc] init];
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        //Prepare attachment file
        
        NSData *csvData = [NSData dataWithContentsOfFile:[self setFileLocation]]; 
        [picker addAttachmentData:csvData mimeType:@"text/csv" fileName:fileName];
        NSLog(@"Data is: %@",csvData);
        
        //setting up email head
        NSArray *recipient = [NSArray arrayWithObject:@"der.coernel@gmail.com"];
        
        //setting up email body
        NSString *mailBody = @"See attached file for the record from ";
        NSString *mailBodyWithDate = [mailBody stringByAppendingString:dateString];
        
        //putting everything in place
        [picker setMessageBody:mailBodyWithDate isHTML:YES];
        [picker setToRecipients:recipient];
        [picker setCcRecipients:nil];
        
        
        //show and release MailComposer
        [self presentModalViewController:picker animated:YES];
    
        
        
    }
    else {
        
        //Pop up a notification
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Could not send email. Verify Internet connection and try again. Please check whether email is set up on the device."
                                                       delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
  
    }
} //fertig


-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	if (result == MFMailComposeResultFailed) {
       UIAlertView *failed = [[UIAlertView alloc] initWithTitle:@"Sending failed" message:@"The file was stored and can be sent later"
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [failed show];
        [failed release];
    }
    
    else if (result == MFMailComposeResultSent) {
        UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success" message:@"The file was sent." 
                                                        delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [success show];
        [success release];
    }
    
    else if (result == MFMailComposeResultCancelled) {
        ///do nothing
    }
    
    [self dismissModalViewControllerAnimated:YES];
    self.view.backgroundColor = [UIColor colorWithRed:0.604 green:0.604 blue:0.604 alpha:1.000];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    NSLog(@"Latitude:%f Longitude:%f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    if (newLocation == nil) 
        self.startingLocation = newLocation;
    
    double distance = [newLocation distanceFromLocation:startingLocation];
    // make up smaller value for testing purpose
    
    if (distance >= 5) {
        [self recordStop];
    }
}


#pragma mark -
#pragma mark View Life Cycle
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}



#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
