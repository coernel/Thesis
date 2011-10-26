//
//  FlipsideViewController.h
//  Gait Monitor
//
//  Created by Sebastian Weiß on 10/25/11.
//  Copyright (c) 2011 Jade Hochschule. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (assign, nonatomic) IBOutlet id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
