//
//  Record.m
//  GaitMonitor for iOS
//
//  Created by Sebastian Weiß on 10/25/11.
//  Copyright (c) 2011 Jade Hochschule. All rights reserved.
//

#import "Record.h"

@implementation Record


@synthesize str_Sex;
@synthesize str_Joint;
@synthesize str_Device;
@synthesize str_FollowUp;
@synthesize str_OSVersion;

@synthesize date_Born;
@synthesize date_DateOfRecord;








-(void)setPatientData:(NSString *)born andHeight:(float *)height andWeight:(float *)weight andSex:(NSString *)sex; {
    
}

-(void)setStudyData:(NSString *)followUp andJoint:(NSString *)joint andDate:(NSDate *)date; {
    
}

-(void)setThesisData:(NSString *)device andVersion:(NSString *)version; {
    
}

-(NSString *)getFileName {
 /*   date_DateOfRecord = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yymmdd"];
       
    NSString *stringFromDate = [formatter stringFromDate:date_DateOfRecord];
    
    return stringFromDate; */
    NSString *testname = [[NSString alloc] initWithFormat:@"test"];
    
    return testname;
    
}
-(NSString *)getFileHeader {

    NSString *today = [[NSString alloc] init];
    today = [self getFileName];
    
    NSString *joint = [[NSString alloc] initWithFormat:@"Operated side: %@",str_Joint];
    NSString *sexAndAge = [[NSString alloc] initWithFormat:@"Patient is:%@ and was born on ",str_Sex, date_Born];
    NSString *visitOnDate = [[NSString alloc] initWithFormat:@"Patient came in for FollowUp: %@ on %@",str_FollowUp,today];
    NSString *thesisInfo = [[NSString alloc] initWithFormat:@"The record was done with software: %@ on following device:%@",str_OSVersion, str_Device];
    
    
    NSString *fileheader = [NSString stringWithFormat:@"%@\n %@\n %@\n\n\n %@\n\n ",joint,sexAndAge,visitOnDate,thesisInfo];
    
    return fileheader;
    
}

@end
