//
//  releaseMainViewController.m
//  GaitMonitor for iOS
//
//  Created by Sebastian Weiß on 10/25/11.
//  Copyright (c) 2011 Jade Hochschule. All rights reserved.
//

#import "releaseMainViewController.h"

@implementation releaseMainViewController

@synthesize ageField, weightField, heightField;
@synthesize studyIDField;
@synthesize sexField;
@synthesize jointField;
@synthesize followUpField;

@synthesize viewRecordsButton;
@synthesize clearAllButton;


- (Record *)aRecord {
    
    return [[Record alloc] autorelease];

}

-(NSString *)dataFilePath { //load an the path to data.plist (creates it, if nonexistent)
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:kFilename];
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
//hide keyboard when touching background

- (IBAction)backgroundTouch:(id)sender { //touch the background to hide keyboard
    [self.view endEditing:YES];
}



-(IBAction)clearAll:(id)sender { //clears the form
    UIAlertView *proceed = [[UIAlertView alloc] initWithTitle:@"Clear Form" message:@"This will erase the form!" 
                                                   delegate:self cancelButtonTitle:@"Proceed" 
                                          otherButtonTitles:@"Cancel", nil];
    [proceed show];
    [proceed release];
}    

- (void)alertView:(UIAlertView *)proceed clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        studyIDField.text = @"";
        weightField.text = @"";
        heightField.text = @"";
        ageField.text = @"";
        
        [sexField setSelectedSegmentIndex:UISegmentedControlNoSegment];
        [jointField setSelectedSegmentIndex:UISegmentedControlNoSegment];
        [followUpField setSelectedSegmentIndex:UISegmentedControlNoSegment];
    }
    
    else
    {
           }
} //responds to clearMethod with AlertView

-(void)done:(id)sender { //loads FlipSide
    

    releaseFlipsideViewController *controller = [[releaseFlipsideViewController alloc] initWithNibName:@"releaseFlipsideViewController" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[self presentModalViewController:controller animated:YES];
    
    
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObject:ageField.text];	
        [array addObject:weightField.text];
        [array addObject:heightField.text];
        [array addObject:studyIDField.text];
        
        NSString *sexString = [[NSString alloc] init];
        sexString = [sexField titleForSegmentAtIndex:sexField.selectedSegmentIndex];
        [array addObject:sexString];
        
        NSString *jointString = [[NSString alloc] init];
        jointString = [jointField titleForSegmentAtIndex:jointField.selectedSegmentIndex];
        [array addObject:jointString];
        
        NSString *followUpString = [[NSString alloc] init];
        followUpString = [followUpField titleForSegmentAtIndex:followUpField.selectedSegmentIndex];
        [array addObject:followUpString];
        
        [array writeToFile:[self dataFilePath] atomically:YES];
        
        [sexString release];
        [jointString release];
        [followUpString release];
    
    
}

-(void)showTable:(id)sender { //loads TableView
    
    releaseRecordViewController *controller = [[releaseRecordViewController alloc] initWithNibName:@"releaseRecordViewController" bundle:nil];
       
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
}
#pragma mark - View lifecycle



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //preparing plists
    NSBundle *bundle = [NSBundle mainBundle];
   // NSString *plistPathWeight = [bundle pathForResource:@"weight" ofType:@"plist"];
   // NSString *plistPathHeight = [bundle pathForResource:@"height" ofType:@"plist"];
    //NSString *plistPathAge    = [bundle pathForResource:@"age" ofType:@"plist"];
    

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}


-(void)applicationWillTerminate:(NSNotification *)notification {
	
	NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:ageField.text];	
	[array addObject:weightField.text];
	[array addObject:heightField.text];
    [array addObject:studyIDField.text];
	
	NSString *sexString = [[NSString alloc] init];
    sexString = [sexField titleForSegmentAtIndex:sexField.selectedSegmentIndex];
    [array addObject:sexString];
    
    NSString *jointString = [[NSString alloc] init];
    jointString = [jointField titleForSegmentAtIndex:jointField.selectedSegmentIndex];
    [array addObject:jointString];
    
    NSString *followUpString = [[NSString alloc] init];
    followUpString = [followUpField titleForSegmentAtIndex:followUpField.selectedSegmentIndex];
    [array addObject:followUpString];
    
	[array writeToFile:[self dataFilePath] atomically:YES];
    
    [sexString release];
    [jointString release];
    [followUpString release];
    
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(releaseFlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}


	
/* for Storyboard Use only
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}
*/
@end
